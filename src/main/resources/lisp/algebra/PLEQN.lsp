
(SDEFUN |PLEQN;inconsistent?;LB;1| ((|pl| (|List| GR)) ($ (|Boolean|)))
        (SPROG ((#1=#:G732 NIL) (#2=#:G733 NIL) (#3=#:G734 NIL) (|p| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |p| NIL) (LETT #3# |pl|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |p| (QREFELT $ 11))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G731)))
                              (GO #5=#:G729))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |PLEQN;inconsistent?;LB;2|
        ((|pl| (|List| (|Polynomial| R))) ($ (|Boolean|)))
        (SPROG ((#1=#:G743 NIL) (#2=#:G744 NIL) (#3=#:G745 NIL) (|p| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |p| NIL) (LETT #3# |pl|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |p| (QREFELT $ 15))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G742)))
                              (GO #5=#:G740))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |PLEQN;B1solve;RR;3|
        ((|sys|
          (|Record| (|:| |mat| (|Matrix| (|Fraction| (|Polynomial| R))))
                    (|:| |vec| (|List| (|Fraction| (|Polynomial| R))))
                    (|:| |rank| (|NonNegativeInteger|))
                    (|:| |rows| (|List| (|Integer|)))
                    (|:| |cols| (|List| (|Integer|)))))
         ($
          (|Record| (|:| |partsol| (|Vector| (|Fraction| (|Polynomial| R))))
                    (|:| |basis|
                         (|List| (|Vector| (|Fraction| (|Polynomial| R))))))))
        (SPROG
         ((|pbas| (|List| (|Vector| (|Fraction| (|Polynomial| R)))))
          (|pb| #1=(|Vector| (|Fraction| (|Polynomial| R)))) (#2=#:G796 NIL)
          (|j| NIL) (|j1| NIL) (#3=#:G795 NIL) (|i| NIL) (|i1| NIL)
          (#4=#:G794 NIL) (#5=#:G793 NIL)
          (|augmat| (|Matrix| (|Fraction| (|Polynomial| R)))) (#6=#:G792 NIL)
          (#7=#:G791 NIL) (#8=#:G790 NIL) (|p| #1#)
          (|w| (|List| (|Fraction| (|Polynomial| R))))
          (|frcols| (|List| (|Integer|))) (|n| (|NonNegativeInteger|))
          (|cmat| (|Matrix| (|Fraction| (|Polynomial| R))))
          (|k| (|NonNegativeInteger|)) (|nss| (|List| (|Integer|)))
          (|rss| (|List| (|Integer|))))
         (SEQ (LETT |rss| (QVELT |sys| 3)) (LETT |nss| (QVELT |sys| 4))
              (LETT |k| (QVELT |sys| 2)) (LETT |cmat| (QVELT |sys| 0))
              (LETT |n| (ANCOLS |cmat|))
              (LETT |frcols|
                    (SPADCALL
                     (SPADCALL (SPADCALL 1 |n| (QREFELT $ 22)) (QREFELT $ 24))
                     |nss| (QREFELT $ 25)))
              (LETT |w| (QVELT |sys| 1))
              (LETT |p| (MAKEARR1 |n| (|spadConstant| $ 29))) (LETT |pbas| NIL)
              (COND
               ((SPADCALL |k| 0 (QREFELT $ 31))
                (SEQ (LETT |augmat| (SPADCALL |k| (+ |n| 1) (QREFELT $ 33)))
                     (SEQ (LETT |i1| 1) (LETT |i| NIL) (LETT #8# |rss|) G190
                          (COND
                           ((OR (ATOM #8#) (PROGN (LETT |i| (CAR #8#)) NIL))
                            (GO G191)))
                          (SEQ
                           (SEQ (LETT |j1| 1) (LETT |j| NIL) (LETT #7# |nss|)
                                G190
                                (COND
                                 ((OR (ATOM #7#)
                                      (PROGN (LETT |j| (CAR #7#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SPADCALL |augmat| |i1| |j1|
                                            (SPADCALL |cmat| |i| |j|
                                                      (QREFELT $ 34))
                                            (QREFELT $ 35))))
                                (LETT #7#
                                      (PROG1 (CDR #7#)
                                        (LETT |j1| (|inc_SI| |j1|))))
                                (GO G190) G191 (EXIT NIL))
                           (SEQ (LETT |j1| (+ |k| 1)) (LETT |j| NIL)
                                (LETT #6# |frcols|) G190
                                (COND
                                 ((OR (ATOM #6#)
                                      (PROGN (LETT |j| (CAR #6#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SPADCALL |augmat| |i1| |j1|
                                            (SPADCALL
                                             (SPADCALL |cmat| |i| |j|
                                                       (QREFELT $ 34))
                                             (QREFELT $ 36))
                                            (QREFELT $ 35))))
                                (LETT #6#
                                      (PROG1 (CDR #6#) (LETT |j1| (+ |j1| 1))))
                                (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (SPADCALL |augmat| |i1| (+ |n| 1)
                                      (SPADCALL |w| |i| (QREFELT $ 38))
                                      (QREFELT $ 35))))
                          (LETT #8#
                                (PROG1 (CDR #8#) (LETT |i1| (|inc_SI| |i1|))))
                          (GO G190) G191 (EXIT NIL))
                     (LETT |augmat| (SPADCALL |augmat| (QREFELT $ 39)))
                     (SEQ (LETT |i1| 1) (LETT |i| NIL) (LETT #5# |nss|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |i| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |p| |i|
                                      (SPADCALL |augmat| |i1| (+ |n| 1)
                                                (QREFELT $ 34))
                                      (QREFELT $ 41))))
                          (LETT #5#
                                (PROG1 (CDR #5#) (LETT |i1| (|inc_SI| |i1|))))
                          (GO G190) G191 (EXIT NIL))
                     (EXIT
                      (SEQ (LETT |j1| (+ |k| 1)) (LETT |j| NIL)
                           (LETT #4# |frcols|) G190
                           (COND
                            ((OR (ATOM #4#) (PROGN (LETT |j| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |pb| (MAKEARR1 |n| (|spadConstant| $ 29)))
                            (SPADCALL |pb| |j| (|spadConstant| $ 42)
                                      (QREFELT $ 41))
                            (SEQ (LETT |i1| 1) (LETT |i| NIL) (LETT #3# |nss|)
                                 G190
                                 (COND
                                  ((OR (ATOM #3#)
                                       (PROGN (LETT |i| (CAR #3#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SPADCALL |pb| |i|
                                             (SPADCALL |augmat| |i1| |j1|
                                                       (QREFELT $ 34))
                                             (QREFELT $ 41))))
                                 (LETT #3#
                                       (PROG1 (CDR #3#)
                                         (LETT |i1| (|inc_SI| |i1|))))
                                 (GO G190) G191 (EXIT NIL))
                            (EXIT (LETT |pbas| (CONS |pb| |pbas|))))
                           (LETT #4# (PROG1 (CDR #4#) (LETT |j1| (+ |j1| 1))))
                           (GO G190) G191 (EXIT NIL)))))
               ('T
                (SEQ (LETT |j1| (+ |k| 1)) (LETT |j| NIL) (LETT #2# |frcols|)
                     G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |j| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |pb| (MAKEARR1 |n| (|spadConstant| $ 29)))
                          (SPADCALL |pb| |j| (|spadConstant| $ 42)
                                    (QREFELT $ 41))
                          (EXIT (LETT |pbas| (CONS |pb| |pbas|))))
                     (LETT #2# (PROG1 (CDR #2#) (LETT |j1| (+ |j1| 1))))
                     (GO G190) G191 (EXIT NIL))))
              (EXIT (CONS |p| |pbas|))))) 

(SDEFUN |PLEQN;regime;RMLL2NniIR;4|
        ((|y|
          (|Record| (|:| |det| GR) (|:| |rows| #1=(|List| (|Integer|)))
                    (|:| |cols| #2=(|List| (|Integer|)))))
         (|coef| (|Matrix| GR)) (|w| (|List| (|Fraction| (|Polynomial| R))))
         (|psbf| (|List| (|List| GR))) (|rk| (|NonNegativeInteger|))
         (|rkmax| (|NonNegativeInteger|)) (|mode| (|Integer|))
         ($
          (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                    (|:| |wcond| (|List| (|Polynomial| R)))
                    (|:| |bsoln|
                         (|Record|
                          (|:| |partsol|
                               (|Vector| (|Fraction| (|Polynomial| R))))
                          (|:| |basis|
                               (|List|
                                (|Vector| (|Fraction| (|Polynomial| R))))))))))
        (SPROG
         ((|test|
           (|Record| (|:| |sysok| (|Boolean|)) (|:| |z0| (|List| GR))
                     (|:| |n0| (|List| GR))))
          (|yzero| (|List| GR)) (#3=#:G837 NIL) (|pw| NIL) (#4=#:G836 NIL)
          (|wcd| (|List| (|Polynomial| R))) (#5=#:G828 NIL)
          (|wnum| (|Polynomial| R)) (|weqn| #6=(|Fraction| (|Polynomial| R)))
          (#7=#:G812 NIL) (#8=#:G811 #6#) (#9=#:G813 #6#) (#10=#:G835 NIL)
          (|j| NIL) (#11=#:G834 NIL) (|i| NIL) (|frows| (|List| (|Integer|)))
          (|pp| #12=(|Vector| (|Fraction| (|Polynomial| R))))
          (|pps|
           (|Record| (|:| |partsol| #12#)
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Polynomial| R)))))))
          (|sys|
           (|Record| (|:| |mat| (|Matrix| (|Fraction| (|Polynomial| R))))
                     (|:| |vec| (|List| (|Fraction| (|Polynomial| R))))
                     (|:| |rank| (|NonNegativeInteger|))
                     (|:| |rows| (|List| (|Integer|)))
                     (|:| |cols| (|List| (|Integer|)))))
          (|nss| #2#) (|rss| #1#)
          (|nc| (|Matrix| (|Fraction| (|Polynomial| R)))) (#13=#:G803 NIL)
          (#14=#:G802 (GR)) (#15=#:G804 (GR)) (#16=#:G833 NIL) (#17=#:G689 NIL)
          (#18=#:G832 NIL) (|x| NIL) (#19=#:G831 NIL) (#20=#:G830 NIL)
          (#21=#:G829 NIL) (|ydetf| (|List| GR)))
         (SEQ
          (EXIT
           (SEQ (LETT |ydetf| (SPADCALL (QVELT |y| 0) (QREFELT $ 46)))
                (LETT |yzero|
                      (COND ((EQL |rk| |rkmax|) NIL)
                            (#22='T
                             (SEQ
                              (LETT |psbf|
                                    (PROGN
                                     (LETT #21# NIL)
                                     (SEQ (LETT |x| NIL) (LETT #20# |psbf|)
                                          G190
                                          (COND
                                           ((OR (ATOM #20#)
                                                (PROGN
                                                 (LETT |x| (CAR #20#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #21#
                                                  (CONS
                                                   (SPADCALL |x| |ydetf|
                                                             (QREFELT $ 47))
                                                   #21#))))
                                          (LETT #20# (CDR #20#)) (GO G190) G191
                                          (EXIT (NREVERSE #21#)))))
                              (EXIT
                               (SPADCALL
                                (PROGN
                                 (LETT #19# NIL)
                                 (SEQ (LETT |x| NIL) (LETT #18# |psbf|) G190
                                      (COND
                                       ((OR (ATOM #18#)
                                            (PROGN (LETT |x| (CAR #18#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #19#
                                              (CONS
                                               (PROGN
                                                (LETT #13# NIL)
                                                (SEQ (LETT #17# NIL)
                                                     (LETT #16# |x|) G190
                                                     (COND
                                                      ((OR (ATOM #16#)
                                                           (PROGN
                                                            (LETT #17#
                                                                  (CAR #16#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (PROGN
                                                        (LETT #15# #17#)
                                                        (COND
                                                         (#13#
                                                          (LETT #14#
                                                                (SPADCALL #14#
                                                                          #15#
                                                                          (QREFELT
                                                                           $
                                                                           48))))
                                                         ('T
                                                          (PROGN
                                                           (LETT #14# #15#)
                                                           (LETT #13# 'T)))))))
                                                     (LETT #16# (CDR #16#))
                                                     (GO G190) G191 (EXIT NIL))
                                                (COND (#13# #14#)
                                                      ('T
                                                       (|spadConstant| $ 19))))
                                               #19#))))
                                      (LETT #18# (CDR #18#)) (GO G190) G191
                                      (EXIT (NREVERSE #19#))))
                                (QREFELT $ 50)))))))
                (LETT |nc|
                      (SPADCALL (SPADCALL |coef| |yzero| (QREFELT $ 52))
                                (QREFELT $ 53)))
                (LETT |rss| (QVELT |y| 1)) (LETT |nss| (QVELT |y| 2))
                (LETT |sys| (VECTOR |nc| |w| |rk| |rss| |nss|))
                (LETT |pps| (SPADCALL |sys| (QREFELT $ 45)))
                (LETT |pp| (QCAR |pps|))
                (LETT |frows|
                      (SPADCALL
                       (SPADCALL (SPADCALL 1 (ANROWS |coef|) (QREFELT $ 22))
                                 (QREFELT $ 24))
                       |rss| (QREFELT $ 25)))
                (LETT |wcd| NIL)
                (EXIT
                 (COND
                  ((SPADCALL |mode| (LIST 3 6 9 12) (QREFELT $ 54))
                   (VECTOR |yzero| |ydetf| |wcd|
                           (SPADCALL |pps| |yzero| (QREFELT $ 55))))
                  (#22#
                   (SEQ
                    (SEQ (LETT |i| NIL) (LETT #11# |frows|) G190
                         (COND
                          ((OR (ATOM #11#) (PROGN (LETT |i| (CAR #11#)) NIL))
                           (GO G191)))
                         (SEQ
                          (LETT |weqn|
                                (PROGN
                                 (LETT #7# NIL)
                                 (SEQ (LETT |j| NIL) (LETT #10# |nss|) G190
                                      (COND
                                       ((OR (ATOM #10#)
                                            (PROGN (LETT |j| (CAR #10#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (PROGN
                                         (LETT #9#
                                               (SPADCALL
                                                (SPADCALL |nc| |i| |j|
                                                          (QREFELT $ 34))
                                                (SPADCALL |pp| |j|
                                                          (QREFELT $ 56))
                                                (QREFELT $ 57)))
                                         (COND
                                          (#7#
                                           (LETT #8#
                                                 (SPADCALL #8# #9#
                                                           (QREFELT $ 58))))
                                          ('T
                                           (PROGN
                                            (LETT #8# #9#)
                                            (LETT #7# 'T)))))))
                                      (LETT #10# (CDR #10#)) (GO G190) G191
                                      (EXIT NIL))
                                 (COND (#7# #8#) ('T (|spadConstant| $ 29)))))
                          (LETT |wnum|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |w| |i| (QREFELT $ 38))
                                           |weqn| (QREFELT $ 59))
                                 (QREFELT $ 60)))
                          (EXIT
                           (COND
                            ((SPADCALL |wnum| (|spadConstant| $ 61)
                                       (QREFELT $ 62))
                             "trivially satisfied")
                            ((SPADCALL |wnum| (QREFELT $ 15))
                             (PROGN
                              (LETT #5#
                                    (VECTOR |yzero| |ydetf|
                                            (LIST (|spadConstant| $ 63))
                                            |pps|))
                              (GO #23=#:G827)))
                            ('T (LETT |wcd| (CONS |wnum| |wcd|))))))
                         (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (COND
                      ((SPADCALL |mode| (LIST 2 5 8 11) (QREFELT $ 54))
                       (VECTOR |yzero| |ydetf| |wcd| |pps|))
                      (#22#
                       (SEQ
                        (COND
                         ((NULL (NULL |wcd|))
                          (LETT |yzero|
                                (SPADCALL
                                 (SPADCALL |yzero|
                                           (PROGN
                                            (LETT #4# NIL)
                                            (SEQ (LETT |pw| NIL)
                                                 (LETT #3# |wcd|) G190
                                                 (COND
                                                  ((OR (ATOM #3#)
                                                       (PROGN
                                                        (LETT |pw| (CAR #3#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #4#
                                                         (CONS
                                                          (SPADCALL |pw|
                                                                    (QREFELT $
                                                                             64))
                                                          #4#))))
                                                 (LETT #3# (CDR #3#)) (GO G190)
                                                 G191 (EXIT (NREVERSE #4#))))
                                           (QREFELT $ 65))
                                 (QREFELT $ 66)))))
                        (LETT |test| (SPADCALL |yzero| |ydetf| (QREFELT $ 68)))
                        (COND
                         ((NULL (QVELT |test| 0))
                          (EXIT
                           (VECTOR (QVELT |test| 1) (QVELT |test| 2)
                                   (LIST (|spadConstant| $ 63)) |pps|))))
                        (EXIT
                         (VECTOR (QVELT |test| 1) (QVELT |test| 2) NIL
                                 (SPADCALL |pps| (QVELT |test| 1)
                                           (QREFELT $ 55))))))))))))))
          #23# (EXIT #5#)))) 

(SDEFUN |PLEQN;bsolve;MLNniSIR;5|
        ((|coeff| (|Matrix| GR)) (|w| (|List| (|Fraction| (|Polynomial| R))))
         (|h| (|NonNegativeInteger|)) (|outname| (|String|))
         (|mode| (|Integer|))
         ($
          (|Record|
           (|:| |rgl|
                (|List|
                 (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                           (|:| |wcond| (|List| (|Polynomial| R)))
                           (|:| |bsoln|
                                (|Record|
                                 (|:| |partsol|
                                      (|Vector| (|Fraction| (|Polynomial| R))))
                                 (|:| |basis|
                                      (|List|
                                       (|Vector|
                                        (|Fraction| (|Polynomial| R))))))))))
           (|:| |rgsz| (|Integer|)))))
        (SPROG
         ((|count| (|Integer|))
          (|lrec3|
           (|List|
            (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                      (|:| |wcond| (|List| (|Polynomial| R)))
                      (|:| |bsoln|
                           (|Record|
                            (|:| |partsol|
                                 (|Vector| (|Fraction| (|Polynomial| R))))
                            (|:| |basis|
                                 (|List|
                                  (|Vector|
                                   (|Fraction| (|Polynomial| R))))))))))
          (|rec3|
           (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                     (|:| |wcond| (|List| (|Polynomial| R)))
                     (|:| |bsoln|
                          (|Record|
                           (|:| |partsol|
                                (|Vector| (|Fraction| (|Polynomial| R))))
                           (|:| |basis|
                                (|List|
                                 (|Vector| (|Fraction| (|Polynomial| R)))))))))
          (#1=#:G862 NIL) (|y| NIL) (|psbf| (|List| (|List| GR)))
          (#2=#:G861 NIL) (|x| NIL) (#3=#:G860 NIL) (|psb| #4=(|List| GR))
          (|pc|
           #5=(|List|
               (|Record| (|:| |det| GR) (|:| |rows| (|List| (|Integer|)))
                         (|:| |cols| (|List| (|Integer|))))))
          (|rk| #6=(|NonNegativeInteger|)) (|k| NIL)
          (|rkmin| (|NonNegativeInteger|)) (|rkmax| (|NonNegativeInteger|))
          (|rrcl|
           (|List|
            (|Record| (|:| |rank| #6#) (|:| |eqns| #5#) (|:| |fgb| #4#))))
          (#7=#:G859 NIL)
          (|rksoln|
           (|File|
            (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                      (|:| |wcond| (|List| (|Polynomial| R)))
                      (|:| |bsoln|
                           (|Record|
                            (|:| |partsol|
                                 (|Vector| (|Fraction| (|Polynomial| R))))
                            (|:| |basis|
                                 (|List|
                                  (|Vector|
                                   (|Fraction| (|Polynomial| R))))))))))
          (|newfile| (|FileName|)) (|filemode| (|Boolean|))
          (|r| (|NonNegativeInteger|)))
         (SEQ (LETT |r| (ANROWS |coeff|))
              (EXIT
               (COND
                ((SPADCALL |r| (LENGTH |w|) (QREFELT $ 31))
                 (|error| "number of rows unequal on lhs and rhs"))
                (#8='T
                 (SEQ (LETT |count| 0) (LETT |lrec3| NIL)
                      (LETT |filemode|
                            (SPADCALL |mode| (LIST 7 8 9 10 11 12)
                                      (QREFELT $ 54)))
                      (COND
                       (|filemode|
                        (SEQ
                         (LETT |newfile|
                               (SPADCALL "" |outname| "regime" (QREFELT $ 75)))
                         (EXIT
                          (LETT |rksoln|
                                (SPADCALL |newfile| (QREFELT $ 77)))))))
                      (LETT |rrcl|
                            (COND
                             ((SPADCALL |mode| (LIST 1 2 3 7 8 9)
                                        (QREFELT $ 54))
                              (SPADCALL |coeff| 0 (QREFELT $ 80)))
                             (#8#
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |mode| (LIST 4 5 6 10 11 12)
                                            (QREFELT $ 54))
                                  (PROGN
                                   (LETT #7#
                                         (SPADCALL |coeff| |h| (QREFELT $ 80)))
                                   (GO #9=#:G844)))))
                               #9# (EXIT #7#)))))
                      (LETT |rkmax| (SPADCALL |rrcl| (QREFELT $ 81)))
                      (LETT |rkmin| (SPADCALL |rrcl| (QREFELT $ 82)))
                      (SEQ (LETT |k| (+ (- |rkmax| |rkmin|) 1)) G190
                           (COND ((< |k| 1) (GO G191)))
                           (SEQ
                            (LETT |rk|
                                  (QVELT (SPADCALL |rrcl| |k| (QREFELT $ 83))
                                         0))
                            (LETT |pc|
                                  (QVELT (SPADCALL |rrcl| |k| (QREFELT $ 83))
                                         1))
                            (LETT |psb|
                                  (COND ((EQL |rk| |rkmax|) NIL)
                                        ('T
                                         (QVELT
                                          (SPADCALL |rrcl| (+ |k| 1)
                                                    (QREFELT $ 83))
                                          2))))
                            (LETT |psbf|
                                  (PROGN
                                   (LETT #3# NIL)
                                   (SEQ (LETT |x| NIL) (LETT #2# |psb|) G190
                                        (COND
                                         ((OR (ATOM #2#)
                                              (PROGN (LETT |x| (CAR #2#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #3#
                                                (CONS
                                                 (SPADCALL |x| (QREFELT $ 46))
                                                 #3#))))
                                        (LETT #2# (CDR #2#)) (GO G190) G191
                                        (EXIT (NREVERSE #3#)))))
                            (LETT |psbf| (SPADCALL |psbf| (QREFELT $ 84)))
                            (EXIT
                             (SEQ (LETT |y| NIL) (LETT #1# |pc|) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |y| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (LETT |rec3|
                                         (SPADCALL |y| |coeff| |w| |psbf| |rk|
                                                   |rkmax| |mode|
                                                   (QREFELT $ 72)))
                                   (EXIT
                                    (COND
                                     ((SPADCALL (QVELT |rec3| 2)
                                                (QREFELT $ 17))
                                      "incompatible system")
                                     ('T
                                      (SEQ
                                       (COND
                                        (|filemode|
                                         (SPADCALL |rksoln| |rec3|
                                                   (QREFELT $ 85)))
                                        ('T
                                         (LETT |lrec3| (CONS |rec3| |lrec3|))))
                                       (EXIT (LETT |count| (+ |count| 1))))))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT NIL))))
                           (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
                      (COND (|filemode| (SPADCALL |rksoln| (QREFELT $ 86))))
                      (EXIT (CONS |lrec3| |count|))))))))) 

(SDEFUN |PLEQN;factorset;GRL;6| ((|y| (GR)) ($ (|List| GR)))
        (SPROG ((#1=#:G878 NIL) (|j| NIL) (#2=#:G877 NIL))
               (SEQ
                (COND ((SPADCALL |y| (QREFELT $ 11)) NIL)
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |j| NIL)
                             (LETT #1#
                                   (SPADCALL (SPADCALL |y| (QREFELT $ 91))
                                             (QREFELT $ 95)))
                             G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |j| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ (EXIT (LETT #2# (CONS (QVELT |j| 1) #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |PLEQN;ParCondList;MNniL;7|
        ((|mat| (|Matrix| GR)) (|h| (|NonNegativeInteger|))
         ($
          (|List|
           #1=(|Record| (|:| |rank| (|NonNegativeInteger|))
                        (|:| |eqns|
                             (|List|
                              (|Record| (|:| |det| GR)
                                        (|:| |rows| (|List| (|Integer|)))
                                        (|:| |cols| (|List| (|Integer|))))))
                        (|:| |fgb| #2=(|List| GR))))))
        (SPROG
         ((|rcl|
           (|List|
            (|Record| (|:| |rank| (|NonNegativeInteger|))
                      (|:| |eqns|
                           (|List|
                            (|Record| (|:| |det| GR)
                                      (|:| |rows| (|List| (|Integer|)))
                                      (|:| |cols| (|List| (|Integer|))))))
                      (|:| |fgb| (|List| GR)))))
          (|pcl| #1#) (|ps| (|List| GR)) (|done| #3=(|Boolean|))
          (|covered| #3#)
          (|npc|
           (|List|
            (|Record| (|:| |det| GR) (|:| |rows| (|List| (|Integer|)))
                      (|:| |cols| (|List| (|Integer|))))))
          (|zro| #2#)
          (|test|
           (|Record| (|:| |sysok| (|Boolean|)) (|:| |z0| (|List| GR))
                     (|:| |n0| (|List| GR))))
          (|p| (GR)) (#4=#:G898 NIL) (|rc| NIL) (#5=#:G899 NIL)
          (|maxrk| (|Integer|))
          (|pc|
           (|List|
            (|Record| (|:| |det| GR) (|:| |rows| (|List| (|Integer|)))
                      (|:| |cols| (|List| (|Integer|))))))
          (#6=#:G896 NIL) (|k| NIL) (#7=#:G897 NIL)
          (|n| (|NonNegativeInteger|)) (|r| (|NonNegativeInteger|)))
         (SEQ (LETT |rcl| NIL) (LETT |ps| NIL) (LETT |pc| NIL) (LETT |npc| NIL)
              (LETT |done| NIL) (LETT |r| (ANROWS |mat|))
              (LETT |n| (ANCOLS |mat|)) (LETT |maxrk| (MIN |r| |n|))
              (SEQ (LETT #7# NIL) (LETT |k| (MIN |r| |n|)) (LETT #6# |h|) G190
                   (COND ((OR (< |k| #6#) #7#) (GO G191)))
                   (SEQ (LETT |pc| (SPADCALL |mat| |k| (QREFELT $ 97)))
                        (LETT |npc| NIL)
                        (COND
                         ((NULL |pc|)
                          (COND ((>= |k| 1) (EXIT (LETT |maxrk| (- |k| 1)))))))
                        (COND
                         ((SPADCALL (QVELT (SPADCALL |pc| 1 (QREFELT $ 98)) 0)
                                    (QREFELT $ 11))
                          (SEQ (LETT |npc| |pc|) (LETT |done| 'T)
                               (EXIT
                                (LETT |ps| (LIST (|spadConstant| $ 19))))))
                         ('T
                          (SEQ
                           (LETT |zro|
                                 (COND ((EQL |k| |maxrk|) NIL)
                                       ('T
                                        (QVELT
                                         (SPADCALL |rcl| 1 (QREFELT $ 83))
                                         2))))
                           (LETT |covered| NIL)
                           (SEQ (LETT #5# NIL) (LETT |rc| NIL) (LETT #4# |pc|)
                                G190
                                (COND
                                 ((OR (ATOM #4#)
                                      (PROGN (LETT |rc| (CAR #4#)) NIL) #5#)
                                  (GO G191)))
                                (SEQ
                                 (LETT |p|
                                       (SPADCALL (QVELT |rc| 0) |zro|
                                                 (QREFELT $ 99)))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |p| (|spadConstant| $ 100)
                                              (QREFELT $ 101))
                                    "incompatible or covered subdeterminant")
                                   ('T
                                    (SEQ
                                     (LETT |test|
                                           (SPADCALL |zro|
                                                     (LIST (QVELT |rc| 0))
                                                     (QREFELT $ 68)))
                                     (COND
                                      ((NULL (QVELT |test| 0))
                                       (EXIT "incompatible or covered")))
                                     (LETT |zro|
                                           (SPADCALL (CONS |p| |zro|)
                                                     (QREFELT $ 50)))
                                     (LETT |npc| (CONS |rc| |npc|))
                                     (EXIT
                                      (LETT |done|
                                            (LETT |covered|
                                                  (SPADCALL |zro|
                                                            (QREFELT $
                                                                     13))))))))))
                                (LETT #4#
                                      (PROG1 (CDR #4#) (LETT #5# |covered|)))
                                (GO G190) G191 (EXIT NIL))
                           (EXIT (LETT |ps| |zro|)))))
                        (LETT |pcl| (VECTOR |k| |npc| |ps|))
                        (EXIT (LETT |rcl| (CONS |pcl| |rcl|))))
                   (LETT |k| (PROG1 (+ |k| -1) (LETT #7# |done|))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |rcl|)))) 

(SDEFUN |PLEQN;redpps;RLR;8|
        ((|pps|
          (|Record| (|:| |partsol| (|Vector| (|Fraction| (|Polynomial| R))))
                    (|:| |basis|
                         (|List| (|Vector| (|Fraction| (|Polynomial| R)))))))
         (|zz| (|List| GR))
         ($
          (|Record| (|:| |partsol| #1=(|Vector| (|Fraction| (|Polynomial| R))))
                    (|:| |basis|
                         #2=(|List|
                             (|Vector| (|Fraction| (|Polynomial| R))))))))
        (SPROG
         ((#3=#:G923 NIL) (|i| NIL)
          (|pbj| (|Vector| (|Fraction| (|Polynomial| R)))) (#4=#:G922 NIL)
          (|j| NIL) (#5=#:G921 NIL) (|denmat| #6=(|Matrix| GR)) (|nummat| #6#)
          (#7=#:G920 NIL) (#8=#:G919 NIL) (#9=#:G918 NIL)
          (|n| (|NonNegativeInteger|)) (|pb| #2#) (|r| (|NonNegativeInteger|))
          (|pv| #1#))
         (SEQ (LETT |pv| (QCAR |pps|)) (LETT |r| (QVSIZE |pv|))
              (LETT |pb| (QCDR |pps|)) (LETT |n| (+ (LENGTH |pb|) 1))
              (LETT |nummat| (SPADCALL |r| |n| (QREFELT $ 102)))
              (LETT |denmat| (SPADCALL |r| |n| (QREFELT $ 102)))
              (SEQ (LETT |i| 1) (LETT #9# |r|) G190
                   (COND ((|greater_SI| |i| #9#) (GO G191)))
                   (SEQ
                    (SPADCALL |nummat| |i| 1
                              (SPADCALL
                               (SPADCALL (SPADCALL |pv| |i| (QREFELT $ 56))
                                         (QREFELT $ 60))
                               (QREFELT $ 64))
                              (QREFELT $ 103))
                    (EXIT
                     (SPADCALL |denmat| |i| 1
                               (SPADCALL
                                (SPADCALL (SPADCALL |pv| |i| (QREFELT $ 56))
                                          (QREFELT $ 104))
                                (QREFELT $ 64))
                               (QREFELT $ 103))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |j| 2) (LETT #8# |n|) G190
                   (COND ((|greater_SI| |j| #8#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |i| 1) (LETT #7# |r|) G190
                          (COND ((|greater_SI| |i| #7#) (GO G191)))
                          (SEQ
                           (SPADCALL |nummat| |i| |j|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |pb| (- |j| 1)
                                                  (QREFELT $ 106))
                                        |i| (QREFELT $ 56))
                                       (QREFELT $ 60))
                                      (QREFELT $ 64))
                                     (QREFELT $ 103))
                           (EXIT
                            (SPADCALL |denmat| |i| |j|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |pb| (- |j| 1)
                                                   (QREFELT $ 106))
                                         |i| (QREFELT $ 56))
                                        (QREFELT $ 104))
                                       (QREFELT $ 64))
                                      (QREFELT $ 103))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (LETT |nummat| (SPADCALL |nummat| |zz| (QREFELT $ 52)))
              (LETT |denmat| (SPADCALL |denmat| |zz| (QREFELT $ 52)))
              (SEQ (LETT |i| 1) (LETT #5# |r|) G190
                   (COND ((|greater_SI| |i| #5#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |pv| |i|
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL |nummat| |i| 1 (QREFELT $ 107))
                                 (QREFELT $ 108))
                                (SPADCALL
                                 (SPADCALL |denmat| |i| 1 (QREFELT $ 107))
                                 (QREFELT $ 108))
                                (QREFELT $ 109))
                               (QREFELT $ 41))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |j| 2) (LETT #4# |n|) G190
                   (COND ((|greater_SI| |j| #4#) (GO G191)))
                   (SEQ (LETT |pbj| (MAKEARR1 |r| (|spadConstant| $ 29)))
                        (SEQ (LETT |i| 1) (LETT #3# |r|) G190
                             (COND ((|greater_SI| |i| #3#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL |pbj| |i|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |nummat| |i| |j|
                                                     (QREFELT $ 107))
                                           (QREFELT $ 108))
                                          (SPADCALL
                                           (SPADCALL |denmat| |i| |j|
                                                     (QREFELT $ 107))
                                           (QREFELT $ 108))
                                          (QREFELT $ 109))
                                         (QREFELT $ 41))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT (SPADCALL |pb| (- |j| 1) |pbj| (QREFELT $ 110))))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |pv| |pb|))))) 

(SDEFUN |PLEQN;dmp2rfi;MM;9|
        ((|mat| (|Matrix| GR)) ($ (|Matrix| (|Fraction| (|Polynomial| R)))))
        (SPROG
         ((#1=#:G931 NIL) (|j| NIL) (#2=#:G930 NIL) (|i| NIL)
          (|nmat| (|Matrix| (|Fraction| (|Polynomial| R))))
          (|n| (|NonNegativeInteger|)) (|r| (|NonNegativeInteger|)))
         (SEQ (LETT |r| (ANROWS |mat|)) (LETT |n| (ANCOLS |mat|))
              (LETT |nmat| (SPADCALL |r| |n| (QREFELT $ 33)))
              (SEQ (LETT |i| 1) (LETT #2# |r|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |nmat| |i| |j|
                                      (SPADCALL
                                       (SPADCALL |mat| |i| |j| (QREFELT $ 107))
                                       (QREFELT $ 108))
                                      (QREFELT $ 35))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |nmat|)))) 

(SDEFUN |PLEQN;dmp2rfi;LL;10|
        ((|vl| (|List| GR)) ($ (|List| (|Fraction| (|Polynomial| R)))))
        (SPROG ((#1=#:G936 NIL) (|v| NIL) (#2=#:G935 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |v| NIL) (LETT #1# |vl|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |v| (QREFELT $ 108)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |PLEQN;psolve;MLL;11|
        ((|mat| (|Matrix| GR)) (|w| (|List| GR))
         ($
          (|List|
           (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                     (|:| |wcond| (|List| (|Polynomial| R)))
                     (|:| |bsoln|
                          (|Record|
                           (|:| |partsol|
                                (|Vector| (|Fraction| (|Polynomial| R))))
                           (|:| |basis|
                                (|List|
                                 (|Vector|
                                  (|Fraction| (|Polynomial| R)))))))))))
        (QCAR
         (SPADCALL |mat| (SPADCALL |w| (QREFELT $ 111)) 1 "nofile" 1
                   (QREFELT $ 88)))) 

(SDEFUN |PLEQN;psolve;MLL;12|
        ((|mat| (|Matrix| GR)) (|w| (|List| (|Symbol|)))
         ($
          (|List|
           (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                     (|:| |wcond| (|List| (|Polynomial| R)))
                     (|:| |bsoln|
                          (|Record|
                           (|:| |partsol|
                                (|Vector| (|Fraction| (|Polynomial| R))))
                           (|:| |basis|
                                (|List|
                                 (|Vector|
                                  (|Fraction| (|Polynomial| R)))))))))))
        (QCAR
         (SPADCALL |mat| (SPADCALL |w| (QREFELT $ 115)) 1 "nofile" 2
                   (QREFELT $ 88)))) 

(SDEFUN |PLEQN;psolve;ML;13|
        ((|mat| (|Matrix| GR))
         ($
          (|List|
           (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                     (|:| |wcond| (|List| (|Polynomial| R)))
                     (|:| |bsoln|
                          (|Record|
                           (|:| |partsol|
                                (|Vector| (|Fraction| (|Polynomial| R))))
                           (|:| |basis|
                                (|List|
                                 (|Vector|
                                  (|Fraction| (|Polynomial| R)))))))))))
        (SPROG ((#1=#:G952 NIL) (|i| NIL) (#2=#:G951 NIL))
               (SEQ
                (QCAR
                 (SPADCALL |mat|
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |i| 1) (LETT #1# (ANROWS |mat|)) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS (|spadConstant| $ 29) #2#))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           1 "nofile" 3 (QREFELT $ 88)))))) 

(SDEFUN |PLEQN;psolve;MLPiL;14|
        ((|mat| (|Matrix| GR)) (|w| (|List| GR)) (|h| (|PositiveInteger|))
         ($
          (|List|
           (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                     (|:| |wcond| (|List| (|Polynomial| R)))
                     (|:| |bsoln|
                          (|Record|
                           (|:| |partsol|
                                (|Vector| (|Fraction| (|Polynomial| R))))
                           (|:| |basis|
                                (|List|
                                 (|Vector|
                                  (|Fraction| (|Polynomial| R)))))))))))
        (QCAR
         (SPADCALL |mat| (SPADCALL |w| (QREFELT $ 111)) |h| "nofile" 4
                   (QREFELT $ 88)))) 

(SDEFUN |PLEQN;psolve;MLPiL;15|
        ((|mat| (|Matrix| GR)) (|w| (|List| (|Symbol|)))
         (|h| (|PositiveInteger|))
         ($
          (|List|
           (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                     (|:| |wcond| (|List| (|Polynomial| R)))
                     (|:| |bsoln|
                          (|Record|
                           (|:| |partsol|
                                (|Vector| (|Fraction| (|Polynomial| R))))
                           (|:| |basis|
                                (|List|
                                 (|Vector|
                                  (|Fraction| (|Polynomial| R)))))))))))
        (QCAR
         (SPADCALL |mat| (SPADCALL |w| (QREFELT $ 115)) |h| "nofile" 5
                   (QREFELT $ 88)))) 

(SDEFUN |PLEQN;psolve;MPiL;16|
        ((|mat| (|Matrix| GR)) (|h| (|PositiveInteger|))
         ($
          (|List|
           (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                     (|:| |wcond| (|List| (|Polynomial| R)))
                     (|:| |bsoln|
                          (|Record|
                           (|:| |partsol|
                                (|Vector| (|Fraction| (|Polynomial| R))))
                           (|:| |basis|
                                (|List|
                                 (|Vector|
                                  (|Fraction| (|Polynomial| R)))))))))))
        (SPROG ((#1=#:G967 NIL) (|i| NIL) (#2=#:G966 NIL))
               (SEQ
                (QCAR
                 (SPADCALL |mat|
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |i| 1) (LETT #1# (ANROWS |mat|)) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS (|spadConstant| $ 29) #2#))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           |h| "nofile" 6 (QREFELT $ 88)))))) 

(SDEFUN |PLEQN;psolve;MLSI;17|
        ((|mat| (|Matrix| GR)) (|w| (|List| GR)) (|outname| (|String|))
         ($ (|Integer|)))
        (QCDR
         (SPADCALL |mat| (SPADCALL |w| (QREFELT $ 111)) 1 |outname| 7
                   (QREFELT $ 88)))) 

(SDEFUN |PLEQN;psolve;MLSI;18|
        ((|mat| (|Matrix| GR)) (|w| (|List| (|Symbol|))) (|outname| (|String|))
         ($ (|Integer|)))
        (QCDR
         (SPADCALL |mat| (SPADCALL |w| (QREFELT $ 115)) 1 |outname| 8
                   (QREFELT $ 88)))) 

(SDEFUN |PLEQN;psolve;MSI;19|
        ((|mat| (|Matrix| GR)) (|outname| (|String|)) ($ (|Integer|)))
        (SPROG ((#1=#:G979 NIL) (|i| NIL) (#2=#:G978 NIL))
               (SEQ
                (QCDR
                 (SPADCALL |mat|
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |i| 1) (LETT #1# (ANROWS |mat|)) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS (|spadConstant| $ 29) #2#))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           1 |outname| 9 (QREFELT $ 88)))))) 

(SDEFUN |PLEQN;nextSublist;2IL;20|
        ((|n| (|Integer|)) (|k| (|Integer|)) ($ (|List| (|List| (|Integer|)))))
        (SPROG
         ((|mslist| (|List| (|List| (|Integer|)))) (#1=#:G984 NIL) (|ms| NIL))
         (SEQ
          (COND ((<= |n| 0) NIL) ((<= |k| 0) (LIST NIL)) ((> |k| |n|) NIL)
                ('T
                 (SEQ
                  (COND
                   ((EQL |n| 1) (COND ((EQL |k| 1) (EXIT (LIST (LIST 1)))))))
                  (LETT |mslist| NIL)
                  (SEQ (LETT |ms| NIL)
                       (LETT #1#
                             (SPADCALL (- |n| 1) (- |k| 1) (QREFELT $ 126)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |ms| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT |mslist|
                               (CONS (SPADCALL |ms| (LIST |n|) (QREFELT $ 127))
                                     |mslist|))))
                       (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (SPADCALL (SPADCALL (- |n| 1) |k| (QREFELT $ 126)) |mslist|
                             (QREFELT $ 128))))))))) 

(SDEFUN |PLEQN;psolve;MLPiSI;21|
        ((|mat| (|Matrix| GR)) (|w| (|List| GR)) (|h| (|PositiveInteger|))
         (|outname| (|String|)) ($ (|Integer|)))
        (QCDR
         (SPADCALL |mat| (SPADCALL |w| (QREFELT $ 111)) |h| |outname| 10
                   (QREFELT $ 88)))) 

(SDEFUN |PLEQN;psolve;MLPiSI;22|
        ((|mat| (|Matrix| GR)) (|w| (|List| (|Symbol|)))
         (|h| (|PositiveInteger|)) (|outname| (|String|)) ($ (|Integer|)))
        (QCDR
         (SPADCALL |mat| (SPADCALL |w| (QREFELT $ 115)) |h| |outname| 11
                   (QREFELT $ 88)))) 

(SDEFUN |PLEQN;psolve;MPiSI;23|
        ((|mat| (|Matrix| GR)) (|h| (|PositiveInteger|)) (|outname| (|String|))
         ($ (|Integer|)))
        (SPROG ((#1=#:G996 NIL) (|i| NIL) (#2=#:G995 NIL))
               (SEQ
                (QCDR
                 (SPADCALL |mat|
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |i| 1) (LETT #1# (ANROWS |mat|)) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS (|spadConstant| $ 29) #2#))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           |h| |outname| 12 (QREFELT $ 88)))))) 

(SDEFUN |PLEQN;hasoln;2LR;24|
        ((|zro| (|List| GR)) (|nzro| (|List| GR))
         ($
          (|Record| (|:| |sysok| (|Boolean|)) (|:| |z0| (|List| GR))
                    (|:| |n0| (|List| GR)))))
        (SPROG
         ((#1=#:G1034 NIL) (|p| NIL) (#2=#:G1033 NIL) (#3=#:G1032 NIL)
          (#4=#:G1031 NIL) (#5=#:G1007 NIL) (#6=#:G1006 (GR)) (#7=#:G1008 (GR))
          (#8=#:G1030 NIL) (#9=#:G691 NIL) (#10=#:G1029 NIL) (|x| NIL)
          (#11=#:G1028 NIL) (|psbf| (|List| (|List| GR))) (#12=#:G1027 NIL)
          (#13=#:G1026 NIL) (#14=#:G1025 NIL) (#15=#:G1024 NIL) (|pnzro| (GR))
          (#16=#:G999 NIL) (#17=#:G998 (GR)) (#18=#:G1000 (GR))
          (#19=#:G1023 NIL) (#20=#:G690 NIL))
         (SEQ
          (COND ((NULL |zro|) (VECTOR 'T |zro| |nzro|))
                (#21='T
                 (SEQ (LETT |zro| (SPADCALL |zro| (QREFELT $ 50)))
                      (EXIT
                       (COND
                        ((SPADCALL |zro| (QREFELT $ 13))
                         (VECTOR NIL |zro| |nzro|))
                        ((NULL |nzro|) (VECTOR 'T |zro| |nzro|))
                        (#21#
                         (SEQ
                          (LETT |pnzro|
                                (SPADCALL
                                 (PROGN
                                  (LETT #16# NIL)
                                  (SEQ (LETT #20# NIL) (LETT #19# |nzro|) G190
                                       (COND
                                        ((OR (ATOM #19#)
                                             (PROGN
                                              (LETT #20# (CAR #19#))
                                              NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (PROGN
                                          (LETT #18# #20#)
                                          (COND
                                           (#16#
                                            (LETT #17#
                                                  (SPADCALL #17# #18#
                                                            (QREFELT $ 48))))
                                           ('T
                                            (PROGN
                                             (LETT #17# #18#)
                                             (LETT #16# 'T)))))))
                                       (LETT #19# (CDR #19#)) (GO G190) G191
                                       (EXIT NIL))
                                  (COND (#16# #17#)
                                        (#21# (|spadConstant| $ 19))))
                                 |zro| (QREFELT $ 99)))
                          (EXIT
                           (COND
                            ((SPADCALL |pnzro| (|spadConstant| $ 100)
                                       (QREFELT $ 101))
                             (VECTOR NIL |zro| |nzro|))
                            (#21#
                             (SEQ
                              (LETT |nzro| (SPADCALL |pnzro| (QREFELT $ 46)))
                              (LETT |psbf|
                                    (SPADCALL
                                     (PROGN
                                      (LETT #15# NIL)
                                      (SEQ (LETT |p| NIL) (LETT #14# |zro|)
                                           G190
                                           (COND
                                            ((OR (ATOM #14#)
                                                 (PROGN
                                                  (LETT |p| (CAR #14#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #15#
                                                   (CONS
                                                    (SPADCALL |p|
                                                              (QREFELT $ 46))
                                                    #15#))))
                                           (LETT #14# (CDR #14#)) (GO G190)
                                           G191 (EXIT (NREVERSE #15#))))
                                     (QREFELT $ 84)))
                              (LETT |psbf|
                                    (PROGN
                                     (LETT #13# NIL)
                                     (SEQ (LETT |x| NIL) (LETT #12# |psbf|)
                                          G190
                                          (COND
                                           ((OR (ATOM #12#)
                                                (PROGN
                                                 (LETT |x| (CAR #12#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #13#
                                                  (CONS
                                                   (SPADCALL |x| |nzro|
                                                             (QREFELT $ 47))
                                                   #13#))))
                                          (LETT #12# (CDR #12#)) (GO G190) G191
                                          (EXIT (NREVERSE #13#)))))
                              (EXIT
                               (COND
                                ((SPADCALL NIL |psbf| (QREFELT $ 132))
                                 (VECTOR NIL |zro| |nzro|))
                                (#21#
                                 (SEQ
                                  (LETT |zro|
                                        (SPADCALL
                                         (PROGN
                                          (LETT #11# NIL)
                                          (SEQ (LETT |x| NIL)
                                               (LETT #10# |psbf|) G190
                                               (COND
                                                ((OR (ATOM #10#)
                                                     (PROGN
                                                      (LETT |x| (CAR #10#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #11#
                                                       (CONS
                                                        (PROGN
                                                         (LETT #5# NIL)
                                                         (SEQ (LETT #9# NIL)
                                                              (LETT #8# |x|)
                                                              G190
                                                              (COND
                                                               ((OR (ATOM #8#)
                                                                    (PROGN
                                                                     (LETT #9#
                                                                           (CAR
                                                                            #8#))
                                                                     NIL))
                                                                (GO G191)))
                                                              (SEQ
                                                               (EXIT
                                                                (PROGN
                                                                 (LETT #7# #9#)
                                                                 (COND
                                                                  (#5#
                                                                   (LETT #6#
                                                                         (SPADCALL
                                                                          #6#
                                                                          #7#
                                                                          (QREFELT
                                                                           $
                                                                           48))))
                                                                  ('T
                                                                   (PROGN
                                                                    (LETT #6#
                                                                          #7#)
                                                                    (LETT #5#
                                                                          'T)))))))
                                                              (LETT #8#
                                                                    (CDR #8#))
                                                              (GO G190) G191
                                                              (EXIT NIL))
                                                         (COND (#5# #6#)
                                                               ('T
                                                                (|spadConstant|
                                                                 $ 19))))
                                                        #11#))))
                                               (LETT #10# (CDR #10#)) (GO G190)
                                               G191 (EXIT (NREVERSE #11#))))
                                         (QREFELT $ 50)))
                                  (EXIT
                                   (COND
                                    ((SPADCALL |zro| (QREFELT $ 13))
                                     (VECTOR NIL |zro| |nzro|))
                                    (#21#
                                     (SEQ
                                      (LETT |nzro|
                                            (PROGN
                                             (LETT #4# NIL)
                                             (SEQ (LETT |p| NIL)
                                                  (LETT #3# |nzro|) G190
                                                  (COND
                                                   ((OR (ATOM #3#)
                                                        (PROGN
                                                         (LETT |p| (CAR #3#))
                                                         NIL))
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT #4#
                                                          (CONS
                                                           (SPADCALL |p| |zro|
                                                                     (QREFELT $
                                                                              99))
                                                           #4#))))
                                                  (LETT #3# (CDR #3#))
                                                  (GO G190) G191
                                                  (EXIT (NREVERSE #4#)))))
                                      (LETT |nzro|
                                            (PROGN
                                             (LETT #2# NIL)
                                             (SEQ (LETT |p| NIL)
                                                  (LETT #1# |nzro|) G190
                                                  (COND
                                                   ((OR (ATOM #1#)
                                                        (PROGN
                                                         (LETT |p| (CAR #1#))
                                                         NIL))
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (COND
                                                     ((NULL
                                                       (SPADCALL |p|
                                                                 (QREFELT $
                                                                          11)))
                                                      (LETT #2#
                                                            (CONS |p| #2#))))))
                                                  (LETT #1# (CDR #1#))
                                                  (GO G190) G191
                                                  (EXIT (NREVERSE #2#)))))
                                      (EXIT
                                       (VECTOR 'T |zro|
                                               |nzro|)))))))))))))))))))))))) 

(SDEFUN |PLEQN;se2rfi;LL;25|
        ((|w| (|List| (|Symbol|))) ($ (|List| (|Fraction| (|Polynomial| R)))))
        (SPROG ((#1=#:G1039 NIL) (|wi| NIL) (#2=#:G1038 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |wi| NIL) (LETT #1# |w|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |wi| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 63) |wi| 1
                                          (QREFELT $ 134))
                                (QREFELT $ 135))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |PLEQN;pr2dmp;PGR;26| ((|p| (|Polynomial| R)) ($ (GR)))
        (COND
         ((SPADCALL |p| (QREFELT $ 15))
          (SPADCALL (SPADCALL |p| (QREFELT $ 136)) (QREFELT $ 137)))
         ('T
          (|algCoerceInteractive| |p| (|Polynomial| (QREFELT $ 6))
                                  (QREFELT $ 9))))) 

(SDEFUN |PLEQN;wrregime;LSI;27|
        ((|lrec3|
          (|List|
           (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                     (|:| |wcond| (|List| (|Polynomial| R)))
                     (|:| |bsoln|
                          (|Record|
                           (|:| |partsol|
                                (|Vector| (|Fraction| (|Polynomial| R))))
                           (|:| |basis|
                                (|List|
                                 (|Vector|
                                  (|Fraction| (|Polynomial| R))))))))))
         (|outname| (|String|)) ($ (|Integer|)))
        (SPROG
         ((|count| (|Integer|)) (#1=#:G1048 NIL) (|rec3| NIL)
          (|rksoln|
           (|File|
            (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                      (|:| |wcond| (|List| (|Polynomial| R)))
                      (|:| |bsoln|
                           (|Record|
                            (|:| |partsol|
                                 (|Vector| (|Fraction| (|Polynomial| R))))
                            (|:| |basis|
                                 (|List|
                                  (|Vector|
                                   (|Fraction| (|Polynomial| R))))))))))
          (|newfile| (|FileName|)))
         (SEQ (LETT |newfile| (SPADCALL "" |outname| "regime" (QREFELT $ 75)))
              (LETT |rksoln| (SPADCALL |newfile| (QREFELT $ 77)))
              (LETT |count| 0)
              (SEQ (LETT |rec3| NIL) (LETT #1# |lrec3|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |rec3| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (SPADCALL |rksoln| |rec3| (QREFELT $ 85))
                        (EXIT (LETT |count| (+ |count| 1))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (SPADCALL |rksoln| (QREFELT $ 86)) (EXIT |count|)))) 

(SDEFUN |PLEQN;dmp2rfi;GRF;28| ((|p| (GR)) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL (CONS #'|PLEQN;dmp2rfi;GRF;28!0| $)
                  (CONS #'|PLEQN;dmp2rfi;GRF;28!1| $) |p| (QREFELT $ 145))) 

(SDEFUN |PLEQN;dmp2rfi;GRF;28!1| ((|r1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |r1| (QREFELT $ 141)) (QREFELT $ 135))) 

(SDEFUN |PLEQN;dmp2rfi;GRF;28!0| ((|v1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |v1| (QREFELT $ 139)) (QREFELT $ 140))) 

(SDEFUN |PLEQN;rdregime;SL;29|
        ((|inname| (|String|))
         ($
          (|List|
           (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                     (|:| |wcond| (|List| (|Polynomial| R)))
                     (|:| |bsoln|
                          (|Record|
                           (|:| |partsol|
                                (|Vector| (|Fraction| (|Polynomial| R))))
                           (|:| |basis|
                                (|List|
                                 (|Vector|
                                  (|Fraction| (|Polynomial| R)))))))))))
        (SPROG
         ((|rec3|
           (|Union|
            (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                      (|:| |wcond| (|List| (|Polynomial| R)))
                      (|:| |bsoln|
                           (|Record|
                            (|:| |partsol|
                                 (|Vector| (|Fraction| (|Polynomial| R))))
                            (|:| |basis|
                                 (|List|
                                  (|Vector| (|Fraction| (|Polynomial| R))))))))
            "failed"))
          (|rksoln|
           (|List|
            (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                      (|:| |wcond| (|List| (|Polynomial| R)))
                      (|:| |bsoln|
                           (|Record|
                            (|:| |partsol|
                                 (|Vector| (|Fraction| (|Polynomial| R))))
                            (|:| |basis|
                                 (|List|
                                  (|Vector|
                                   (|Fraction| (|Polynomial| R))))))))))
          (#1=#:G1054 NIL)
          (|infile|
           (|File|
            (|Record| (|:| |eqzro| (|List| GR)) (|:| |neqzro| (|List| GR))
                      (|:| |wcond| (|List| (|Polynomial| R)))
                      (|:| |bsoln|
                           (|Record|
                            (|:| |partsol|
                                 (|Vector| (|Fraction| (|Polynomial| R))))
                            (|:| |basis|
                                 (|List|
                                  (|Vector|
                                   (|Fraction| (|Polynomial| R))))))))))
          (|infilename| (|FileName|)))
         (SEQ
          (LETT |infilename| (SPADCALL "" |inname| "regime" (QREFELT $ 146)))
          (LETT |infile| (SPADCALL |infilename| "input" (QREFELT $ 147)))
          (LETT |rksoln| NIL) (LETT |rec3| (SPADCALL |infile| (QREFELT $ 149)))
          (SEQ G190 (COND ((NULL (QEQCAR |rec3| 0)) (GO G191)))
               (SEQ
                (LETT |rksoln|
                      (CONS
                       (PROG2 (LETT #1# |rec3|)
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0)
                                         (|Record|
                                          (|:| |eqzro| (|List| (QREFELT $ 9)))
                                          (|:| |neqzro| (|List| (QREFELT $ 9)))
                                          (|:| |wcond|
                                               (|List|
                                                (|Polynomial| (QREFELT $ 6))))
                                          (|:| |bsoln|
                                               (|Record|
                                                (|:| |partsol|
                                                     (|Vector|
                                                      (|Fraction|
                                                       (|Polynomial|
                                                        (QREFELT $ 6)))))
                                                (|:| |basis|
                                                     (|List|
                                                      (|Vector|
                                                       (|Fraction|
                                                        (|Polynomial|
                                                         (QREFELT $ 6)))))))))
                                         (|Union|
                                          (|Record|
                                           (|:| |eqzro| (|List| (QREFELT $ 9)))
                                           (|:| |neqzro|
                                                (|List| (QREFELT $ 9)))
                                           (|:| |wcond|
                                                (|List|
                                                 (|Polynomial| (QREFELT $ 6))))
                                           (|:| |bsoln|
                                                (|Record|
                                                 (|:| |partsol|
                                                      (|Vector|
                                                       (|Fraction|
                                                        (|Polynomial|
                                                         (QREFELT $ 6)))))
                                                 (|:| |basis|
                                                      (|List|
                                                       (|Vector|
                                                        (|Fraction|
                                                         (|Polynomial|
                                                          (QREFELT $ 6)))))))))
                                          "failed")
                                         #1#))
                       |rksoln|))
                (EXIT (LETT |rec3| (SPADCALL |infile| (QREFELT $ 149)))))
               NIL (GO G190) G191 (EXIT NIL))
          (SPADCALL |infile| (QREFELT $ 86)) (EXIT |rksoln|)))) 

(SDEFUN |PLEQN;maxrank;LNni;30|
        ((|rcl|
          (|List|
           (|Record| (|:| |rank| #1=(|NonNegativeInteger|))
                     (|:| |eqns|
                          (|List|
                           (|Record| (|:| |det| GR)
                                     (|:| |rows| (|List| (|Integer|)))
                                     (|:| |cols| (|List| (|Integer|))))))
                     (|:| |fgb| (|List| GR)))))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#2=#:G1063 NIL) (#3=#:G1062 #1#) (#4=#:G1064 #1#) (#5=#:G1067 NIL)
          (|j| NIL))
         (SEQ
          (COND ((NULL |rcl|) 0)
                (#6='T
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |j| NIL) (LETT #5# |rcl|) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |j| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4# (QVELT |j| 0))
                          (COND (#2# (LETT #3# (MAX #3# #4#)))
                                ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#2# #3#) (#6# (|IdentityError| '|max|))))))))) 

(SDEFUN |PLEQN;minrank;LNni;31|
        ((|rcl|
          (|List|
           (|Record| (|:| |rank| #1=(|NonNegativeInteger|))
                     (|:| |eqns|
                          (|List|
                           (|Record| (|:| |det| GR)
                                     (|:| |rows| (|List| (|Integer|)))
                                     (|:| |cols| (|List| (|Integer|))))))
                     (|:| |fgb| (|List| GR)))))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((#2=#:G1070 NIL) (#3=#:G1069 #1#) (#4=#:G1071 #1#) (#5=#:G1074 NIL)
          (|j| NIL))
         (SEQ
          (COND ((NULL |rcl|) 0)
                (#6='T
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |j| NIL) (LETT #5# |rcl|) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |j| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4# (QVELT |j| 0))
                          (COND (#2# (LETT #3# (MIN #3# #4#)))
                                ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#2# #3#) (#6# (|IdentityError| '|min|))))))))) 

(SDEFUN |PLEQN;minset;2L;32|
        ((|lset| (|List| (|List| GR))) ($ (|List| (|List| GR))))
        (SPROG ((#1=#:G1081 NIL) (|x| NIL) (#2=#:G1080 NIL))
               (SEQ
                (COND ((NULL |lset|) |lset|)
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |x| NIL) (LETT #1# |lset|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((NULL (SPADCALL |x| |lset| (QREFELT $ 151)))
                                 (LETT #2# (CONS |x| #2#))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |PLEQN;sqfree;2GR;33| ((|p| (GR)) ($ (GR)))
        (SPROG
         ((#1=#:G1084 NIL) (#2=#:G1083 (GR)) (#3=#:G1085 (GR)) (#4=#:G1087 NIL)
          (|j| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |j| NIL)
                (LETT #4#
                      (SPADCALL (SPADCALL |p| (QREFELT $ 153)) (QREFELT $ 95)))
                G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |j| (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3# (QVELT |j| 1))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 48))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 19))))))) 

(SDEFUN |PLEQN;ParCond;MNniL;34|
        ((|mat| (|Matrix| GR)) (|k| #1=(|NonNegativeInteger|))
         ($
          (|List|
           #2=(|Record| (|:| |det| GR) (|:| |rows| (|List| (|Integer|)))
                        (|:| |cols| (|List| (|Integer|)))))))
        (SPROG
         ((|DetEqn|
           (|List|
            (|Record| (|:| |det| GR) (|:| |rows| (|List| (|Integer|)))
                      (|:| |cols| (|List| (|Integer|))))))
          (|neweqn| #2#) (|detmat| (GR)) (|found| (|Boolean|))
          (|matsub| (|SquareMatrix| |j| GR)) (#3=#:G1103 NIL) (|nss| NIL)
          (#4=#:G1104 NIL) (#5=#:G1101 NIL) (|rss| NIL) (#6=#:G1102 NIL)
          (|n| (|Integer|)) (|r| (|Integer|)) (|j| #1#))
         (SEQ
          (COND ((EQL |k| 0) (LIST (VECTOR (|spadConstant| $ 19) NIL NIL)))
                (#7='T
                 (SEQ (LETT |j| |k|) (LETT |DetEqn| NIL)
                      (LETT |r| (ANROWS |mat|)) (LETT |n| (ANCOLS |mat|))
                      (EXIT
                       (COND
                        ((> |k| (MIN |r| |n|))
                         (|error| "k exceeds maximum possible rank "))
                        (#7#
                         (SEQ (LETT |found| NIL)
                              (SEQ (LETT #6# NIL) (LETT |rss| NIL)
                                   (LETT #5#
                                         (SPADCALL |r| |k| (QREFELT $ 126)))
                                   G190
                                   (COND
                                    ((OR (ATOM #5#)
                                         (PROGN (LETT |rss| (CAR #5#)) NIL)
                                         #6#)
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (SEQ (LETT #4# NIL) (LETT |nss| NIL)
                                          (LETT #3#
                                                (SPADCALL |n| |k|
                                                          (QREFELT $ 126)))
                                          G190
                                          (COND
                                           ((OR (ATOM #3#)
                                                (PROGN
                                                 (LETT |nss| (CAR #3#))
                                                 NIL)
                                                #4#)
                                            (GO G191)))
                                          (SEQ
                                           (LETT |matsub|
                                                 (SPADCALL |mat| |rss| |nss|
                                                           (QREFELT $ 155)))
                                           (LETT |detmat|
                                                 (SPADCALL |matsub|
                                                           (|compiledLookupCheck|
                                                            '|determinant|
                                                            (LIST
                                                             (|devaluate|
                                                              (ELT $ 9))
                                                             '$)
                                                            (|SquareMatrix| |j|
                                                                            (ELT
                                                                             $
                                                                             9)))))
                                           (EXIT
                                            (COND
                                             ((SPADCALL |detmat|
                                                        (|spadConstant| $ 100)
                                                        (QREFELT $ 156))
                                              (SEQ
                                               (LETT |found|
                                                     (SPADCALL |detmat|
                                                               (QREFELT $ 11)))
                                               (LETT |detmat|
                                                     (SPADCALL |detmat|
                                                               (QREFELT $
                                                                        154)))
                                               (LETT |neweqn|
                                                     (VECTOR |detmat| |rss|
                                                             |nss|))
                                               (EXIT
                                                (LETT |DetEqn|
                                                      (CONS |neweqn|
                                                            |DetEqn|))))))))
                                          (LETT #3#
                                                (PROG1 (CDR #3#)
                                                  (LETT #4# |found|)))
                                          (GO G190) G191 (EXIT NIL))))
                                   (LETT #5#
                                         (PROG1 (CDR #5#) (LETT #6# |found|)))
                                   (GO G190) G191 (EXIT NIL))
                              (EXIT
                               (COND (|found| (LIST (|SPADfirst| |DetEqn|)))
                                     (#7#
                                      (SPADCALL
                                       (CONS #'|PLEQN;ParCond;MNniL;34!0| $)
                                       |DetEqn| (QREFELT $ 160))))))))))))))) 

(SDEFUN |PLEQN;ParCond;MNniL;34!0| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (SPADCALL (SPADCALL (QVELT |z1| 0) (QREFELT $ 157))
                  (SPADCALL (QVELT |z2| 0) (QREFELT $ 157)) (QREFELT $ 158))) 

(SDEFUN |PLEQN;overset?;LLB;35|
        ((|p| (|List| GR)) (|qlist| (|List| (|List| GR))) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1106 NIL) (#2=#:G1105 #3=(|Boolean|)) (#4=#:G1107 #3#)
          (#5=#:G1110 NIL) (|q| NIL))
         (SEQ
          (COND ((NULL |qlist|) NIL)
                (#6='T
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT |q| NIL) (LETT #5# |qlist|) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |q| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4#
                                (SPADCALL (SPADCALL |q| (QREFELT $ 162))
                                          (SPADCALL |p| (QREFELT $ 162))
                                          (QREFELT $ 163)))
                          (COND (#1# (LETT #2# (COND (#2# 'T) ('T #4#))))
                                ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#6# NIL)))))))) 

(SDEFUN |PLEQN;redmat;MLM;36|
        ((|mat| (|Matrix| GR)) (|psb| (|List| GR)) ($ (|Matrix| GR)))
        (SPROG
         ((|p| (GR)) (#1=#:G1119 NIL) (|j| NIL) (#2=#:G1118 NIL) (|i| NIL)
          (|newmat| (|Matrix| GR)) (|n| (|NonNegativeInteger|))
          (|r| (|NonNegativeInteger|)))
         (SEQ (LETT |r| (ANROWS |mat|)) (LETT |n| (ANCOLS |mat|))
              (LETT |newmat| (SPADCALL |r| |n| (QREFELT $ 102)))
              (SEQ (LETT |i| 1) (LETT #2# |r|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ
                           (LETT |p| (SPADCALL |mat| |i| |j| (QREFELT $ 107)))
                           (EXIT
                            (COND
                             ((SPADCALL |p| (QREFELT $ 11))
                              (SPADCALL |newmat| |i| |j| |p| (QREFELT $ 103)))
                             ('T
                              (SPADCALL |newmat| |i| |j|
                                        (SPADCALL |p| |psb| (QREFELT $ 99))
                                        (QREFELT $ 103))))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |newmat|)))) 

(DECLAIM (NOTINLINE |ParametricLinearEquations;|)) 

(DEFUN |ParametricLinearEquations| (&REST #1=#:G1120)
  (SPROG NIL
         (PROG (#2=#:G1121)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ParametricLinearEquations|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ParametricLinearEquations;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ParametricLinearEquations|)))))))))) 

(DEFUN |ParametricLinearEquations;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|ParametricLinearEquations| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 164))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|ParametricLinearEquations|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|ParametricLinearEquations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Boolean|) (0 . |ground?|)
              (|List| 9) |PLEQN;inconsistent?;LB;1| (|Polynomial| 6)
              (5 . |ground?|) (|List| 14) |PLEQN;inconsistent?;LB;2|
              (10 . |One|) (14 . |One|) (|Integer|) (|Segment| 20)
              (18 . SEGMENT) (|List| 20) (24 . |expand|) (29 . |setDifference|)
              (35 . |Zero|) (39 . |Zero|) (|Fraction| 14) (43 . |Zero|)
              (|NonNegativeInteger|) (47 . ~=) (|Matrix| 28) (53 . |zero|)
              (59 . |elt|) (66 . |setelt!|) (74 . -) (|List| 28) (79 . |elt|)
              (85 . |rowEchelon|) (|Vector| 28) (90 . |setelt!|) (97 . |One|)
              (|Record| (|:| |partsol| 40) (|:| |basis| 105))
              (|Record| (|:| |mat| 32) (|:| |vec| 37) (|:| |rank| 30)
                        (|:| |rows| 23) (|:| |cols| 23))
              |PLEQN;B1solve;RR;3| |PLEQN;factorset;GRL;6|
              (101 . |setDifference|) (107 . *)
              (|EuclideanGroebnerBasisPackage| 6 8 7 9)
              (113 . |euclideanGroebner|) (|Matrix| 9) |PLEQN;redmat;MLM;36|
              |PLEQN;dmp2rfi;MM;9| (118 . |entry?|) |PLEQN;redpps;RLR;8|
              (124 . |elt|) (130 . *) (136 . +) (142 . -) (148 . |numer|)
              (153 . |Zero|) (157 . =) (163 . |One|) |PLEQN;pr2dmp;PGR;26|
              (167 . |append|) (173 . |removeDuplicates|)
              (|Record| (|:| |sysok| 10) (|:| |z0| 12) (|:| |n0| 12))
              |PLEQN;hasoln;2LR;24|
              (|Record| (|:| |eqzro| 12) (|:| |neqzro| 12) (|:| |wcond| 16)
                        (|:| |bsoln| 43))
              (|Record| (|:| |det| 9) (|:| |rows| 23) (|:| |cols| 23))
              (|List| 12) |PLEQN;regime;RMLL2NniIR;4| (|String|) (|FileName|)
              (178 . |new|) (|File| 69) (185 . |open|)
              (|Record| (|:| |rank| 30) (|:| |eqns| 96) (|:| |fgb| 12))
              (|List| 78) |PLEQN;ParCondList;MNniL;7| |PLEQN;maxrank;LNni;30|
              |PLEQN;minrank;LNni;31| (190 . |elt|) |PLEQN;minset;2L;32|
              (196 . |write!|) (202 . |close!|)
              (|Record| (|:| |rgl| 112) (|:| |rgsz| 20))
              |PLEQN;bsolve;MLNniSIR;5| (|Factored| 9)
              (|MultivariateFactorize| 7 8 6 9) (207 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 92) (|:| |factor| 9) (|:| |exponent| 30))
              (|List| 93) (212 . |factorList|) (|List| 70)
              |PLEQN;ParCond;MNniL;34| (217 . |elt|)
              (223 . |euclideanNormalForm|) (229 . |Zero|) (233 . =)
              (239 . |zero|) (245 . |setelt!|) (253 . |denom|) (|List| 40)
              (258 . |elt|) (264 . |elt|) |PLEQN;dmp2rfi;GRF;28| (271 . /)
              (277 . |setelt!|) |PLEQN;dmp2rfi;LL;10| (|List| 69)
              |PLEQN;psolve;MLL;11| (|List| 133) |PLEQN;se2rfi;LL;25|
              |PLEQN;psolve;MLL;12| |PLEQN;psolve;ML;13| (|PositiveInteger|)
              |PLEQN;psolve;MLPiL;14| |PLEQN;psolve;MLPiL;15|
              |PLEQN;psolve;MPiL;16| |PLEQN;psolve;MLSI;17|
              |PLEQN;psolve;MLSI;18| |PLEQN;psolve;MSI;19| (|List| 23)
              |PLEQN;nextSublist;2IL;20| (284 . |append|) (290 . |append|)
              |PLEQN;psolve;MLPiSI;21| |PLEQN;psolve;MLPiSI;22|
              |PLEQN;psolve;MPiSI;23| (296 . |entry?|) (|Symbol|)
              (302 . |monomial|) (309 . |coerce|) (314 . |ground|)
              (319 . |coerce|) |PLEQN;wrregime;LSI;27| (324 . |convert|)
              (329 . |coerce|) (334 . |coerce|) (|Mapping| 28 7)
              (|Mapping| 28 6) (|PolynomialCategoryLifting| 8 7 6 9 28)
              (339 . |map|) (346 . |filename|) (353 . |open|)
              (|Union| 69 '"failed") (359 . |readIfCan!|)
              |PLEQN;rdregime;SL;29| |PLEQN;overset?;LLB;35| (|Factored| $)
              (364 . |squareFree|) |PLEQN;sqfree;2GR;33| (369 . |elt|)
              (376 . ~=) (382 . |degree|) (387 . <) (|Mapping| 10 70 70)
              (393 . |sort|) (|Set| 9) (399 . |set|) (404 . <))
           '#(|wrregime| 410 |sqfree| 416 |se2rfi| 421 |regime| 426 |redpps|
              437 |redmat| 443 |rdregime| 449 |psolve| 454 |pr2dmp| 534
              |overset?| 539 |nextSublist| 545 |minset| 551 |minrank| 556
              |maxrank| 561 |inconsistent?| 566 |hasoln| 576 |factorset| 582
              |dmp2rfi| 587 |bsolve| 602 |ParCondList| 611 |ParCond| 617
              |B1solve| 623)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|psolve|
                                 ((|List|
                                   (|Record| (|:| |eqzro| (|List| |#4|))
                                             (|:| |neqzro| (|List| |#4|))
                                             (|:| |wcond|
                                                  (|List| (|Polynomial| |#1|)))
                                             (|:| |bsoln|
                                                  (|Record|
                                                   (|:| |partsol|
                                                        (|Vector|
                                                         (|Fraction|
                                                          (|Polynomial|
                                                           |#1|))))
                                                   (|:| |basis|
                                                        (|List|
                                                         (|Vector|
                                                          (|Fraction|
                                                           (|Polynomial|
                                                            |#1|)))))))))
                                  (|Matrix| |#4|) (|List| |#4|)))
                                T)
                              '((|psolve|
                                 ((|List|
                                   (|Record| (|:| |eqzro| (|List| |#4|))
                                             (|:| |neqzro| (|List| |#4|))
                                             (|:| |wcond|
                                                  (|List| (|Polynomial| |#1|)))
                                             (|:| |bsoln|
                                                  (|Record|
                                                   (|:| |partsol|
                                                        (|Vector|
                                                         (|Fraction|
                                                          (|Polynomial|
                                                           |#1|))))
                                                   (|:| |basis|
                                                        (|List|
                                                         (|Vector|
                                                          (|Fraction|
                                                           (|Polynomial|
                                                            |#1|)))))))))
                                  (|Matrix| |#4|) (|List| (|Symbol|))))
                                T)
                              '((|psolve|
                                 ((|List|
                                   (|Record| (|:| |eqzro| (|List| |#4|))
                                             (|:| |neqzro| (|List| |#4|))
                                             (|:| |wcond|
                                                  (|List| (|Polynomial| |#1|)))
                                             (|:| |bsoln|
                                                  (|Record|
                                                   (|:| |partsol|
                                                        (|Vector|
                                                         (|Fraction|
                                                          (|Polynomial|
                                                           |#1|))))
                                                   (|:| |basis|
                                                        (|List|
                                                         (|Vector|
                                                          (|Fraction|
                                                           (|Polynomial|
                                                            |#1|)))))))))
                                  (|Matrix| |#4|)))
                                T)
                              '((|psolve|
                                 ((|List|
                                   (|Record| (|:| |eqzro| (|List| |#4|))
                                             (|:| |neqzro| (|List| |#4|))
                                             (|:| |wcond|
                                                  (|List| (|Polynomial| |#1|)))
                                             (|:| |bsoln|
                                                  (|Record|
                                                   (|:| |partsol|
                                                        (|Vector|
                                                         (|Fraction|
                                                          (|Polynomial|
                                                           |#1|))))
                                                   (|:| |basis|
                                                        (|List|
                                                         (|Vector|
                                                          (|Fraction|
                                                           (|Polynomial|
                                                            |#1|)))))))))
                                  (|Matrix| |#4|) (|List| |#4|)
                                  (|PositiveInteger|)))
                                T)
                              '((|psolve|
                                 ((|List|
                                   (|Record| (|:| |eqzro| (|List| |#4|))
                                             (|:| |neqzro| (|List| |#4|))
                                             (|:| |wcond|
                                                  (|List| (|Polynomial| |#1|)))
                                             (|:| |bsoln|
                                                  (|Record|
                                                   (|:| |partsol|
                                                        (|Vector|
                                                         (|Fraction|
                                                          (|Polynomial|
                                                           |#1|))))
                                                   (|:| |basis|
                                                        (|List|
                                                         (|Vector|
                                                          (|Fraction|
                                                           (|Polynomial|
                                                            |#1|)))))))))
                                  (|Matrix| |#4|) (|List| (|Symbol|))
                                  (|PositiveInteger|)))
                                T)
                              '((|psolve|
                                 ((|List|
                                   (|Record| (|:| |eqzro| (|List| |#4|))
                                             (|:| |neqzro| (|List| |#4|))
                                             (|:| |wcond|
                                                  (|List| (|Polynomial| |#1|)))
                                             (|:| |bsoln|
                                                  (|Record|
                                                   (|:| |partsol|
                                                        (|Vector|
                                                         (|Fraction|
                                                          (|Polynomial|
                                                           |#1|))))
                                                   (|:| |basis|
                                                        (|List|
                                                         (|Vector|
                                                          (|Fraction|
                                                           (|Polynomial|
                                                            |#1|)))))))))
                                  (|Matrix| |#4|) (|PositiveInteger|)))
                                T)
                              '((|psolve|
                                 ((|Integer|) (|Matrix| |#4|) (|List| |#4|)
                                  (|String|)))
                                T)
                              '((|psolve|
                                 ((|Integer|) (|Matrix| |#4|)
                                  (|List| (|Symbol|)) (|String|)))
                                T)
                              '((|psolve|
                                 ((|Integer|) (|Matrix| |#4|) (|String|)))
                                T)
                              '((|psolve|
                                 ((|Integer|) (|Matrix| |#4|) (|List| |#4|)
                                  (|PositiveInteger|) (|String|)))
                                T)
                              '((|psolve|
                                 ((|Integer|) (|Matrix| |#4|)
                                  (|List| (|Symbol|)) (|PositiveInteger|)
                                  (|String|)))
                                T)
                              '((|psolve|
                                 ((|Integer|) (|Matrix| |#4|)
                                  (|PositiveInteger|) (|String|)))
                                T)
                              '((|wrregime|
                                 ((|Integer|)
                                  (|List|
                                   (|Record| (|:| |eqzro| (|List| |#4|))
                                             (|:| |neqzro| (|List| |#4|))
                                             (|:| |wcond|
                                                  (|List| (|Polynomial| |#1|)))
                                             (|:| |bsoln|
                                                  (|Record|
                                                   (|:| |partsol|
                                                        (|Vector|
                                                         (|Fraction|
                                                          (|Polynomial|
                                                           |#1|))))
                                                   (|:| |basis|
                                                        (|List|
                                                         (|Vector|
                                                          (|Fraction|
                                                           (|Polynomial|
                                                            |#1|)))))))))
                                  (|String|)))
                                T)
                              '((|rdregime|
                                 ((|List|
                                   (|Record| (|:| |eqzro| (|List| |#4|))
                                             (|:| |neqzro| (|List| |#4|))
                                             (|:| |wcond|
                                                  (|List| (|Polynomial| |#1|)))
                                             (|:| |bsoln|
                                                  (|Record|
                                                   (|:| |partsol|
                                                        (|Vector|
                                                         (|Fraction|
                                                          (|Polynomial|
                                                           |#1|))))
                                                   (|:| |basis|
                                                        (|List|
                                                         (|Vector|
                                                          (|Fraction|
                                                           (|Polynomial|
                                                            |#1|)))))))))
                                  (|String|)))
                                T)
                              '((|bsolve|
                                 ((|Record|
                                   (|:| |rgl|
                                        (|List|
                                         (|Record| (|:| |eqzro| (|List| |#4|))
                                                   (|:| |neqzro| (|List| |#4|))
                                                   (|:| |wcond|
                                                        (|List|
                                                         (|Polynomial| |#1|)))
                                                   (|:| |bsoln|
                                                        (|Record|
                                                         (|:| |partsol|
                                                              (|Vector|
                                                               (|Fraction|
                                                                (|Polynomial|
                                                                 |#1|))))
                                                         (|:| |basis|
                                                              (|List|
                                                               (|Vector|
                                                                (|Fraction|
                                                                 (|Polynomial|
                                                                  |#1|))))))))))
                                   (|:| |rgsz| (|Integer|)))
                                  (|Matrix| |#4|)
                                  (|List| (|Fraction| (|Polynomial| |#1|)))
                                  (|NonNegativeInteger|) (|String|)
                                  (|Integer|)))
                                T)
                              '((|dmp2rfi|
                                 ((|Fraction| (|Polynomial| |#1|)) |#4|))
                                T)
                              '((|dmp2rfi|
                                 ((|Matrix| (|Fraction| (|Polynomial| |#1|)))
                                  (|Matrix| |#4|)))
                                T)
                              '((|dmp2rfi|
                                 ((|List| (|Fraction| (|Polynomial| |#1|)))
                                  (|List| |#4|)))
                                T)
                              '((|se2rfi|
                                 ((|List| (|Fraction| (|Polynomial| |#1|)))
                                  (|List| (|Symbol|))))
                                T)
                              '((|pr2dmp| (|#4| (|Polynomial| |#1|))) T)
                              '((|hasoln|
                                 ((|Record| (|:| |sysok| (|Boolean|))
                                            (|:| |z0| (|List| |#4|))
                                            (|:| |n0| (|List| |#4|)))
                                  (|List| |#4|) (|List| |#4|)))
                                T)
                              '((|ParCondList|
                                 ((|List|
                                   (|Record|
                                    (|:| |rank| (|NonNegativeInteger|))
                                    (|:| |eqns|
                                         (|List|
                                          (|Record| (|:| |det| |#4|)
                                                    (|:| |rows|
                                                         (|List| (|Integer|)))
                                                    (|:| |cols|
                                                         (|List|
                                                          (|Integer|))))))
                                    (|:| |fgb| (|List| |#4|))))
                                  (|Matrix| |#4|) (|NonNegativeInteger|)))
                                T)
                              '((|redpps|
                                 ((|Record|
                                   (|:| |partsol|
                                        (|Vector|
                                         (|Fraction| (|Polynomial| |#1|))))
                                   (|:| |basis|
                                        (|List|
                                         (|Vector|
                                          (|Fraction| (|Polynomial| |#1|))))))
                                  (|Record|
                                   (|:| |partsol|
                                        (|Vector|
                                         (|Fraction| (|Polynomial| |#1|))))
                                   (|:| |basis|
                                        (|List|
                                         (|Vector|
                                          (|Fraction| (|Polynomial| |#1|))))))
                                  (|List| |#4|)))
                                T)
                              '((|B1solve|
                                 ((|Record|
                                   (|:| |partsol|
                                        (|Vector|
                                         (|Fraction| (|Polynomial| |#1|))))
                                   (|:| |basis|
                                        (|List|
                                         (|Vector|
                                          (|Fraction| (|Polynomial| |#1|))))))
                                  (|Record|
                                   (|:| |mat|
                                        (|Matrix|
                                         (|Fraction| (|Polynomial| |#1|))))
                                   (|:| |vec|
                                        (|List|
                                         (|Fraction| (|Polynomial| |#1|))))
                                   (|:| |rank| (|NonNegativeInteger|))
                                   (|:| |rows| (|List| (|Integer|)))
                                   (|:| |cols| (|List| (|Integer|))))))
                                T)
                              '((|factorset| ((|List| |#4|) |#4|)) T)
                              '((|maxrank|
                                 ((|NonNegativeInteger|)
                                  (|List|
                                   (|Record|
                                    (|:| |rank| (|NonNegativeInteger|))
                                    (|:| |eqns|
                                         (|List|
                                          (|Record| (|:| |det| |#4|)
                                                    (|:| |rows|
                                                         (|List| (|Integer|)))
                                                    (|:| |cols|
                                                         (|List|
                                                          (|Integer|))))))
                                    (|:| |fgb| (|List| |#4|))))))
                                T)
                              '((|minrank|
                                 ((|NonNegativeInteger|)
                                  (|List|
                                   (|Record|
                                    (|:| |rank| (|NonNegativeInteger|))
                                    (|:| |eqns|
                                         (|List|
                                          (|Record| (|:| |det| |#4|)
                                                    (|:| |rows|
                                                         (|List| (|Integer|)))
                                                    (|:| |cols|
                                                         (|List|
                                                          (|Integer|))))))
                                    (|:| |fgb| (|List| |#4|))))))
                                T)
                              '((|minset|
                                 ((|List| (|List| |#4|))
                                  (|List| (|List| |#4|))))
                                T)
                              '((|nextSublist|
                                 ((|List| (|List| (|Integer|))) (|Integer|)
                                  (|Integer|)))
                                T)
                              '((|overset?|
                                 ((|Boolean|) (|List| |#4|)
                                  (|List| (|List| |#4|))))
                                T)
                              '((|ParCond|
                                 ((|List|
                                   (|Record| (|:| |det| |#4|)
                                             (|:| |rows| (|List| (|Integer|)))
                                             (|:| |cols|
                                                  (|List| (|Integer|)))))
                                  (|Matrix| |#4|) (|NonNegativeInteger|)))
                                T)
                              '((|redmat|
                                 ((|Matrix| |#4|) (|Matrix| |#4|)
                                  (|List| |#4|)))
                                T)
                              '((|regime|
                                 ((|Record| (|:| |eqzro| (|List| |#4|))
                                            (|:| |neqzro| (|List| |#4|))
                                            (|:| |wcond|
                                                 (|List| (|Polynomial| |#1|)))
                                            (|:| |bsoln|
                                                 (|Record|
                                                  (|:| |partsol|
                                                       (|Vector|
                                                        (|Fraction|
                                                         (|Polynomial| |#1|))))
                                                  (|:| |basis|
                                                       (|List|
                                                        (|Vector|
                                                         (|Fraction|
                                                          (|Polynomial|
                                                           |#1|))))))))
                                  (|Record| (|:| |det| |#4|)
                                            (|:| |rows| (|List| (|Integer|)))
                                            (|:| |cols| (|List| (|Integer|))))
                                  (|Matrix| |#4|)
                                  (|List| (|Fraction| (|Polynomial| |#1|)))
                                  (|List| (|List| |#4|)) (|NonNegativeInteger|)
                                  (|NonNegativeInteger|) (|Integer|)))
                                T)
                              '((|sqfree| (|#4| |#4|)) T)
                              '((|inconsistent?| ((|Boolean|) (|List| |#4|)))
                                T)
                              '((|inconsistent?|
                                 ((|Boolean|) (|List| (|Polynomial| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 163
                                            '(1 9 10 0 11 1 14 10 0 15 0 6 0 18
                                              0 9 0 19 2 21 0 20 20 22 1 21 23
                                              0 24 2 23 0 0 0 25 0 6 0 26 0 8 0
                                              27 0 28 0 29 2 30 10 0 0 31 2 32
                                              0 30 30 33 3 32 28 0 20 20 34 4
                                              32 28 0 20 20 28 35 1 28 0 0 36 2
                                              37 28 0 20 38 1 32 0 0 39 3 40 28
                                              0 20 28 41 0 28 0 42 2 12 0 0 0
                                              47 2 9 0 0 0 48 1 49 12 12 50 2
                                              23 10 20 0 54 2 40 28 0 20 56 2
                                              28 0 0 0 57 2 28 0 0 0 58 2 28 0
                                              0 0 59 1 28 14 0 60 0 14 0 61 2
                                              14 10 0 0 62 0 14 0 63 2 12 0 0 0
                                              65 1 12 0 0 66 3 74 0 73 73 73 75
                                              1 76 0 74 77 2 79 78 0 20 83 2 76
                                              69 0 69 85 1 76 0 0 86 1 90 89 9
                                              91 1 89 94 0 95 2 96 70 0 20 98 2
                                              49 9 9 12 99 0 9 0 100 2 9 10 0 0
                                              101 2 51 0 30 30 102 4 51 9 0 20
                                              20 9 103 1 28 14 0 104 2 105 40 0
                                              20 106 3 51 9 0 20 20 107 2 28 0
                                              0 0 109 3 105 40 0 20 40 110 2 23
                                              0 0 0 127 2 125 0 0 0 128 2 71 10
                                              12 0 132 3 14 0 0 133 30 134 1 28
                                              0 14 135 1 14 6 0 136 1 9 0 6 137
                                              1 7 133 0 139 1 28 0 133 140 1 14
                                              0 6 141 3 144 28 142 143 9 145 3
                                              74 0 73 73 73 146 2 76 0 74 73
                                              147 1 76 148 0 149 1 9 152 0 153
                                              3 51 0 0 23 23 155 2 9 10 0 0 156
                                              1 9 8 0 157 2 8 10 0 0 158 2 96 0
                                              159 0 160 1 161 0 12 162 2 161 10
                                              0 0 163 2 0 20 112 73 138 1 0 9 9
                                              154 1 0 37 114 115 7 0 69 70 51
                                              37 71 30 30 20 72 2 0 43 43 12 55
                                              2 0 51 51 12 52 1 0 112 73 150 2
                                              0 112 51 114 116 2 0 112 51 12
                                              113 3 0 112 51 12 118 119 1 0 112
                                              51 117 2 0 112 51 118 121 3 0 112
                                              51 114 118 120 3 0 20 51 12 73
                                              122 2 0 20 51 73 124 3 0 20 51
                                              114 73 123 4 0 20 51 114 118 73
                                              130 4 0 20 51 12 118 73 129 3 0
                                              20 51 118 73 131 1 0 9 14 64 2 0
                                              10 12 71 151 2 0 125 20 20 126 1
                                              0 71 71 84 1 0 30 79 82 1 0 30 79
                                              81 1 0 10 16 17 1 0 10 12 13 2 0
                                              67 12 12 68 1 0 12 9 46 1 0 28 9
                                              108 1 0 37 12 111 1 0 32 51 53 5
                                              0 87 51 37 30 73 20 88 2 0 79 51
                                              30 80 2 0 96 51 30 97 1 0 43 44
                                              45)))))
           '|lookupComplete|)) 
