
(SDEFUN |OREMAT;rowEchelon;2M;1| ((|m| (|Matrix| LO)) ($ (|Matrix| LO)))
        (QCAR (SPADCALL |m| (|spadConstant| $ 8) NIL (QREFELT $ 13)))) 

(SDEFUN |OREMAT;rowEchelon;MFLR;2|
        ((|m| (|Matrix| LO)) (|cc| (F)) (|lv| (|List| (|Vector| F)))
         ($
          (|Record| (|:| |mat| (|Matrix| LO))
                    (|:| |vecs| (|List| (|Vector| F))))))
        (SPROG
         ((|i| (|Integer|)) (#1=#:G763 NIL) (|w| NIL) (#2=#:G762 NIL)
          (|k1| NIL) (|r| (LO)) (|q| (LO))
          (|#G18| (|Record| (|:| |quotient| LO) (|:| |remainder| LO)))
          (|mkj| (LO)) (#3=#:G761 NIL) (|k| NIL) (|elf2| (F)) (|elf1| (F))
          (#4=#:G760 NIL) (|el2| (LO)) (|el1| (LO)) (#5=#:G759 NIL) (|v| (LO))
          (|u| (LO)) (|d| (LO)) (|c| (LO)) (|mij| (LO))
          (|#G14|
           (|Record| (|:| |generator| LO) (|:| |coef1| LO) (|:| |coef2| LO)
                     (|:| |coefu| LO) (|:| |coefv| LO)))
          (#6=#:G758 NIL) (#7=#:G757 NIL) (|mm| (|Matrix| LO))
          (|dpiv| (|Integer|)) (|pivk| (|Integer|))
          (|dp1| (|NonNegativeInteger|)) (#8=#:G756 NIL) (#9=#:G751 NIL)
          (#10=#:G755 NIL) (|j| NIL) (#11=#:G754 NIL)
          (|nr| (|NonNegativeInteger|)) (|nc| (|NonNegativeInteger|))
          (|lw| (|List| (|Vector| F))) (#12=#:G753 NIL) (|vv| NIL)
          (#13=#:G752 NIL))
         (SEQ (LETT |mm| (SPADCALL |m| (QREFELT $ 15)))
              (LETT |lw|
                    (PROGN
                     (LETT #13# NIL)
                     (SEQ (LETT |vv| NIL) (LETT #12# |lv|) G190
                          (COND
                           ((OR (ATOM #12#) (PROGN (LETT |vv| (CAR #12#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #13#
                                  (CONS (SPADCALL |vv| (QREFELT $ 17)) #13#))))
                          (LETT #12# (CDR #12#)) (GO G190) G191
                          (EXIT (NREVERSE #13#)))))
              (LETT |nc| (ANCOLS |mm|)) (LETT |nr| (ANROWS |mm|))
              (SEQ (LETT |w| NIL) (LETT #11# |lw|) G190
                   (COND
                    ((OR (ATOM #11#) (PROGN (LETT |w| (CAR #11#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (QVSIZE |w|) |nc| (QREFELT $ 20))
                       (|error|
                        "rowEchelon: elements of lv must have size = ncols(m)")))))
                   (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
              (LETT |i| 1)
              (SEQ
               (EXIT
                (SEQ (LETT |j| 1) (LETT #10# |nc|) G190
                     (COND ((|greater_SI| |j| #10#) (GO G191)))
                     (SEQ
                      (COND
                       ((> |i| |nr|)
                        (PROGN (LETT #9# |$NoValue|) (GO #14=#:G748))))
                      (LETT |pivk| -1) (LETT |dpiv| -1)
                      (SEQ (LETT |k| |i|) (LETT #8# |nr|) G190
                           (COND ((> |k| #8#) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((NULL
                                (SPADCALL
                                 (LETT |mkj|
                                       (SPADCALL |mm| |k| |j| (QREFELT $ 24)))
                                 (QREFELT $ 25)))
                               (SEQ
                                (LETT |dp1| (SPADCALL |mkj| (QREFELT $ 26)))
                                (EXIT
                                 (COND
                                  ((OR (EQL |dpiv| -1) (< |dp1| |dpiv|))
                                   (SEQ (LETT |mij| |mkj|) (LETT |pivk| |k|)
                                        (EXIT (LETT |dpiv| |dp1|)))))))))))
                           (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND ((EQL |dpiv| -1) "iterate")
                             ('T
                              (SEQ
                               (LETT |mm|
                                     (SPADCALL |mm| |i| |pivk| (QREFELT $ 27)))
                               (SEQ (LETT |w| NIL) (LETT #7# |lw|) G190
                                    (COND
                                     ((OR (ATOM #7#)
                                          (PROGN (LETT |w| (CAR #7#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (SPADCALL |w| |i| |pivk|
                                                (QREFELT $ 29))))
                                    (LETT #7# (CDR #7#)) (GO G190) G191
                                    (EXIT NIL))
                               (SEQ (LETT |k| (+ |i| 1)) (LETT #6# |nr|) G190
                                    (COND ((> |k| #6#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((NULL
                                         (SPADCALL
                                          (LETT |mkj|
                                                (SPADCALL |mm| |k| |j|
                                                          (QREFELT $ 24)))
                                          (QREFELT $ 25)))
                                        (SEQ
                                         (PROGN
                                          (LETT |#G14|
                                                (SPADCALL |mij| |mkj|
                                                          (QREFELT $ 31)))
                                          (LETT |mij| (QVELT |#G14| 0))
                                          (LETT |c| (QVELT |#G14| 1))
                                          (LETT |d| (QVELT |#G14| 2))
                                          (LETT |u| (QVELT |#G14| 3))
                                          (LETT |v| (QVELT |#G14| 4))
                                          |#G14|)
                                         (SEQ (LETT |k1| (+ |j| 1))
                                              (LETT #5# |nc|) G190
                                              (COND ((> |k1| #5#) (GO G191)))
                                              (SEQ
                                               (LETT |el1|
                                                     (QAREF2O |mm| |i| |k1| 1
                                                              1))
                                               (LETT |el2|
                                                     (QAREF2O |mm| |k| |k1| 1
                                                              1))
                                               (QSETAREF2O |mm| |i| |k1|
                                                           (SPADCALL
                                                            (SPADCALL |c| |el1|
                                                                      (QREFELT
                                                                       $ 32))
                                                            (SPADCALL |d| |el2|
                                                                      (QREFELT
                                                                       $ 32))
                                                            (QREFELT $ 33))
                                                           1 1)
                                               (EXIT
                                                (QSETAREF2O |mm| |k| |k1|
                                                            (SPADCALL
                                                             (SPADCALL |u|
                                                                       |el1|
                                                                       (QREFELT
                                                                        $ 32))
                                                             (SPADCALL |v|
                                                                       |el2|
                                                                       (QREFELT
                                                                        $ 32))
                                                             (QREFELT $ 33))
                                                            1 1)))
                                              (LETT |k1| (+ |k1| 1)) (GO G190)
                                              G191 (EXIT NIL))
                                         (SEQ (LETT |w| NIL) (LETT #4# |lw|)
                                              G190
                                              (COND
                                               ((OR (ATOM #4#)
                                                    (PROGN
                                                     (LETT |w| (CAR #4#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (LETT |elf1|
                                                     (QAREF1O |w| |i| 1))
                                               (LETT |elf2|
                                                     (QAREF1O |w| |k| 1))
                                               (QSETAREF1O |w| |i|
                                                           (SPADCALL
                                                            (SPADCALL |c| |cc|
                                                                      |elf1|
                                                                      (QREFELT
                                                                       $ 34))
                                                            (SPADCALL |d| |cc|
                                                                      |elf2|
                                                                      (QREFELT
                                                                       $ 34))
                                                            (QREFELT $ 35))
                                                           1)
                                               (EXIT
                                                (QSETAREF1O |w| |k|
                                                            (SPADCALL
                                                             (SPADCALL |u| |cc|
                                                                       |elf1|
                                                                       (QREFELT
                                                                        $ 34))
                                                             (SPADCALL |v| |cc|
                                                                       |elf2|
                                                                       (QREFELT
                                                                        $ 34))
                                                             (QREFELT $ 35))
                                                            1)))
                                              (LETT #4# (CDR #4#)) (GO G190)
                                              G191 (EXIT NIL))
                                         (QSETAREF2O |mm| |i| |j| |mij| 1 1)
                                         (EXIT
                                          (QSETAREF2O |mm| |k| |j|
                                                      (|spadConstant| $ 9) 1
                                                      1)))))))
                                    (LETT |k| (+ |k| 1)) (GO G190) G191
                                    (EXIT NIL))
                               (SEQ (LETT |k| 1) (LETT #3# (- |i| 1)) G190
                                    (COND ((|greater_SI| |k| #3#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL
                                         (LETT |mkj|
                                               (SPADCALL |mm| |k| |j|
                                                         (QREFELT $ 24)))
                                         (QREFELT $ 25))
                                        "iterate")
                                       ('T
                                        (SEQ
                                         (PROGN
                                          (LETT |#G18|
                                                (SPADCALL |mkj| |mij|
                                                          (QREFELT $ 37)))
                                          (LETT |q| (QCAR |#G18|))
                                          (LETT |r| (QCDR |#G18|))
                                          |#G18|)
                                         (QSETAREF2O |mm| |k| |j| |r| 1 1)
                                         (SEQ (LETT |k1| (+ |j| 1))
                                              (LETT #2# |nc|) G190
                                              (COND ((> |k1| #2#) (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (QSETAREF2O |mm| |k| |k1|
                                                            (SPADCALL
                                                             (QAREF2O |mm| |k|
                                                                      |k1| 1 1)
                                                             (SPADCALL |q|
                                                                       (QAREF2O
                                                                        |mm|
                                                                        |i|
                                                                        |k1| 1
                                                                        1)
                                                                       (QREFELT
                                                                        $ 32))
                                                             (QREFELT $ 38))
                                                            1 1)))
                                              (LETT |k1| (+ |k1| 1)) (GO G190)
                                              G191 (EXIT NIL))
                                         (EXIT
                                          (SEQ (LETT |w| NIL) (LETT #1# |lw|)
                                               G190
                                               (COND
                                                ((OR (ATOM #1#)
                                                     (PROGN
                                                      (LETT |w| (CAR #1#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (QSETAREF1O |w| |k|
                                                             (SPADCALL
                                                              (QAREF1O |w| |k|
                                                                       1)
                                                              (SPADCALL |q|
                                                                        |cc|
                                                                        (QAREF1O
                                                                         |w|
                                                                         |i| 1)
                                                                        (QREFELT
                                                                         $ 34))
                                                              (QREFELT $ 39))
                                                             1)))
                                               (LETT #1# (CDR #1#)) (GO G190)
                                               G191 (EXIT NIL))))))))
                                    (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT (LETT |i| (+ |i| 1))))))))
                     (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL)))
               #14# (EXIT #9#))
              (EXIT (CONS |mm| |lw|))))) 

(SDEFUN |OREMAT;triangular_solve|
        ((|m| (|Matrix| LO)) (|cc| (F)) (|lv| (|List| (|Vector| F)))
         (|solf|
          (|Mapping|
           #1=(|Record|
               (|:| |particular|
                    #2=(|List|
                        (|Record| (|:| |ratpart| F)
                                  (|:| |coeffs| #3=(|Vector| F)))))
               (|:| |basis| (|List| F)))
           LO (|List| F)))
         ($
          (|Union|
           (|Record|
            (|:| |particular|
                 (|List|
                  (|Record| (|:| |ratpart| (|Vector| F))
                            (|:| |coeffs| (|Vector| F)))))
            (|:| |basis| (|List| (|Vector| F))))
           "failed")))
        (SPROG
         ((#4=#:G876 NIL) (|ba| NIL) (#5=#:G877 NIL) (#6=#:G875 NIL)
          (|bvl| (|List| (|Vector| F))) (|cba| (|List| #7=(|Vector| F)))
          (|cb| (|List| #7#)) (|ncba| (|List| (|Vector| F)))
          (|na| (|Vector| F)) (|ncb| (|List| (|Vector| F))) (|bv| #7#)
          (#8=#:G874 NIL) (|k| NIL) (|nbcv2| #7#) (#9=#:G873 NIL) (|nbcv1| #7#)
          (#10=#:G871 NIL) (|j| NIL) (#11=#:G872 NIL) (|slj| NIL)
          (|nsl2| (|List| F)) (|nbvl| (|List| (|Vector| F))) (#12=#:G870 NIL)
          (|nbcv| #7#) (#13=#:G842 NIL) (#14=#:G841 NIL)
          (|nrl1| (|NonNegativeInteger|)) (#15=#:G869 NIL) (#16=#:G868 NIL)
          (|ss| (F)) (#17=#:G867 NIL) (|slk| NIL) (#18=#:G866 NIL)
          (|noff| (|NonNegativeInteger|)) (|cm2| (|Matrix| F))
          (|cm1| (|Matrix| F)) (#19=#:G865 NIL) (|ncv| NIL) (#20=#:G864 NIL)
          (|nsl1| (|List| F)) (#21=#:G863 NIL) (|pr| NIL) (#22=#:G862 NIL)
          (|ncvl| (|List| #3#)) (#23=#:G861 NIL) (#24=#:G860 NIL)
          (|nrl| (|NonNegativeInteger|)) (|prl| #2#) (#25=#:G859 NIL)
          (|be| NIL) (|resi| #1#) (|lvi| (|List| F)) (|lvi2| (|List| F))
          (|vvi| (F)) (#26=#:G858 NIL) (#27=#:G856 NIL) (#28=#:G857 NIL)
          (|lvi1| (|List| F)) (#29=#:G855 NIL) (#30=#:G854 NIL)
          (|nbas| #31=(|NonNegativeInteger|)) (|nlvi| (|NonNegativeInteger|))
          (#32=#:G853 NIL) (#33=#:G852 NIL) (|lvi0| (|List| F))
          (#34=#:G851 NIL) (|v| NIL) (#35=#:G850 NIL) (#36=#:G843 NIL)
          (|i| NIL) (#37=#:G848 NIL) (#38=#:G849 NIL) (#39=#:G847 NIL)
          (#40=#:G846 NIL) (#41=#:G845 NIL) (#42=#:G844 NIL) (|n| #31#)
          (|nr| (|NonNegativeInteger|)) (|nc| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |nc| (ANCOLS |m|)) (LETT |nr| (ANROWS |m|))
                (EXIT
                 (COND ((> |nc| |nr|) (CONS 1 "failed"))
                       ('T
                        (SEQ (LETT |n| (LENGTH |lv|)) (LETT |bvl| NIL)
                             (LETT |cb|
                                   (PROGN
                                    (LETT #42# NIL)
                                    (SEQ (LETT |i| 1) (LETT #41# |n|) G190
                                         (COND
                                          ((|greater_SI| |i| #41#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #42#
                                                 (CONS
                                                  (MAKEARR1 |n|
                                                            (|spadConstant| $
                                                                            8))
                                                  #42#))))
                                         (LETT |i| (|inc_SI| |i|)) (GO G190)
                                         G191 (EXIT (NREVERSE #42#)))))
                             (LETT |cba|
                                   (PROGN
                                    (LETT #40# NIL)
                                    (SEQ (LETT #39# |cb|) G190
                                         (COND
                                          ((OR (ATOM #39#)
                                               (PROGN
                                                (LETT |bv| (CAR #39#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #40#
                                                 (CONS
                                                  (MAKEARR1 |nc|
                                                            (|spadConstant| $
                                                                            8))
                                                  #40#))))
                                         (LETT #39# (CDR #39#)) (GO G190) G191
                                         (EXIT (NREVERSE #40#)))))
                             (SEQ (LETT #38# |cb|) (LETT |i| 1) (LETT #37# |n|)
                                  G190
                                  (COND
                                   ((OR (|greater_SI| |i| #37#) (ATOM #38#)
                                        (PROGN (LETT |bv| (CAR #38#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (SPADCALL |bv| |i| (|spadConstant| $ 21)
                                              (QREFELT $ 40))))
                                  (LETT |i|
                                        (PROG1 (|inc_SI| |i|)
                                          (LETT #38# (CDR #38#))))
                                  (GO G190) G191 (EXIT NIL))
                             (SEQ (LETT |i| |nc|) G190
                                  (COND ((< |i| 1) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (SPADCALL |m| |i| |i| (QREFELT $ 24))
                                       (|spadConstant| $ 9) (QREFELT $ 41))
                                      (PROGN
                                       (LETT #36# (CONS 1 "failed"))
                                       (GO #43=#:G840)))
                                     ('T
                                      (SEQ
                                       (LETT |lvi0|
                                             (PROGN
                                              (LETT #35# NIL)
                                              (SEQ (LETT |v| NIL)
                                                   (LETT #34# |lv|) G190
                                                   (COND
                                                    ((OR (ATOM #34#)
                                                         (PROGN
                                                          (LETT |v| (CAR #34#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT #35#
                                                           (CONS
                                                            (SPADCALL |v| |i|
                                                                      (QREFELT
                                                                       $ 42))
                                                            #35#))))
                                                   (LETT #34# (CDR #34#))
                                                   (GO G190) G191
                                                   (EXIT (NREVERSE #35#)))))
                                       (LETT |lvi1|
                                             (PROGN
                                              (LETT #33# NIL)
                                              (SEQ (LETT #32# |cb|) G190
                                                   (COND
                                                    ((OR (ATOM #32#)
                                                         (PROGN
                                                          (LETT |bv|
                                                                (CAR #32#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT #33#
                                                           (CONS
                                                            (SPADCALL |bv|
                                                                      |lvi0|
                                                                      (QREFELT
                                                                       $ 45))
                                                            #33#))))
                                                   (LETT #32# (CDR #32#))
                                                   (GO G190) G191
                                                   (EXIT (NREVERSE #33#)))))
                                       (LETT |nlvi| (LENGTH |lvi1|))
                                       (LETT |nbas| (LENGTH |bvl|))
                                       (LETT |lvi1|
                                             (SPADCALL |lvi1|
                                                       (PROGN
                                                        (LETT #30# NIL)
                                                        (SEQ (LETT #29# |bvl|)
                                                             G190
                                                             (COND
                                                              ((OR (ATOM #29#)
                                                                   (PROGN
                                                                    (LETT |bv|
                                                                          (CAR
                                                                           #29#))
                                                                    NIL))
                                                               (GO G191)))
                                                             (SEQ
                                                              (EXIT
                                                               (LETT #30#
                                                                     (CONS
                                                                      (|spadConstant|
                                                                       $ 8)
                                                                      #30#))))
                                                             (LETT #29#
                                                                   (CDR #29#))
                                                             (GO G190) G191
                                                             (EXIT
                                                              (NREVERSE
                                                               #30#))))
                                                       (QREFELT $ 46)))
                                       (LETT |lvi2| NIL)
                                       (SEQ (LETT #28# |lvi1|)
                                            (LETT #27#
                                                  (SPADCALL |cba| |bvl|
                                                            (QREFELT $ 47)))
                                            G190
                                            (COND
                                             ((OR (ATOM #27#)
                                                  (PROGN
                                                   (LETT |bv| (CAR #27#))
                                                   NIL)
                                                  (ATOM #28#)
                                                  (PROGN
                                                   (LETT |vvi| (CAR #28#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (SEQ (LETT |j| (+ |i| 1))
                                                  (LETT #26# |nc|) G190
                                                  (COND
                                                   ((> |j| #26#) (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |vvi|
                                                          (SPADCALL |vvi|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      |m| |i|
                                                                      |j|
                                                                      (QREFELT
                                                                       $ 24))
                                                                     |cc|
                                                                     (SPADCALL
                                                                      |bv| |j|
                                                                      (QREFELT
                                                                       $ 42))
                                                                     (QREFELT $
                                                                              34))
                                                                    (QREFELT $
                                                                             39)))))
                                                  (LETT |j| (+ |j| 1))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (LETT |lvi2|
                                                    (CONS |vvi| |lvi2|))))
                                            (LETT #27#
                                                  (PROG1 (CDR #27#)
                                                    (LETT #28# (CDR #28#))))
                                            (GO G190) G191 (EXIT NIL))
                                       (LETT |lvi| (NREVERSE |lvi2|))
                                       (LETT |resi|
                                             (SPADCALL
                                              (SPADCALL |m| |i| |i|
                                                        (QREFELT $ 24))
                                              |lvi| |solf|))
                                       (LETT |nbvl| NIL)
                                       (SEQ (LETT |be| NIL)
                                            (LETT #25# (QCDR |resi|)) G190
                                            (COND
                                             ((OR (ATOM #25#)
                                                  (PROGN
                                                   (LETT |be| (CAR #25#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (LETT |bv|
                                                   (MAKEARR1 |nc|
                                                             (|spadConstant| $
                                                                             8)))
                                             (SPADCALL |bv| |i| |be|
                                                       (QREFELT $ 40))
                                             (EXIT
                                              (LETT |nbvl|
                                                    (CONS |bv| |nbvl|))))
                                            (LETT #25# (CDR #25#)) (GO G190)
                                            G191 (EXIT NIL))
                                       (LETT |prl| (QCAR |resi|))
                                       (LETT |nrl| (LENGTH |prl|))
                                       (LETT |ncvl|
                                             (PROGN
                                              (LETT #24# NIL)
                                              (SEQ (LETT |pr| NIL)
                                                   (LETT #23# |prl|) G190
                                                   (COND
                                                    ((OR (ATOM #23#)
                                                         (PROGN
                                                          (LETT |pr|
                                                                (CAR #23#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT #24#
                                                           (CONS (QCDR |pr|)
                                                                 #24#))))
                                                   (LETT #23# (CDR #23#))
                                                   (GO G190) G191
                                                   (EXIT (NREVERSE #24#)))))
                                       (LETT |nsl1|
                                             (PROGN
                                              (LETT #22# NIL)
                                              (SEQ (LETT |pr| NIL)
                                                   (LETT #21# |prl|) G190
                                                   (COND
                                                    ((OR (ATOM #21#)
                                                         (PROGN
                                                          (LETT |pr|
                                                                (CAR #21#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT #22#
                                                           (CONS (QCAR |pr|)
                                                                 #22#))))
                                                   (LETT #21# (CDR #21#))
                                                   (GO G190) G191
                                                   (EXIT (NREVERSE #22#)))))
                                       (LETT |cm1|
                                             (SPADCALL
                                              (PROGN
                                               (LETT #20# NIL)
                                               (SEQ (LETT |ncv| NIL)
                                                    (LETT #19# |ncvl|) G190
                                                    (COND
                                                     ((OR (ATOM #19#)
                                                          (PROGN
                                                           (LETT |ncv|
                                                                 (CAR #19#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (LETT #20#
                                                            (CONS
                                                             (SPADCALL |ncv|
                                                                       (QREFELT
                                                                        $ 48))
                                                             #20#))))
                                                    (LETT #19# (CDR #19#))
                                                    (GO G190) G191
                                                    (EXIT (NREVERSE #20#))))
                                              (QREFELT $ 51)))
                                       (LETT |cm2|
                                             (SPADCALL
                                              (SPADCALL |cm1|
                                                        (SPADCALL |nrl|
                                                                  (|spadConstant|
                                                                   $ 21)
                                                                  (QREFELT $
                                                                           53))
                                                        (QREFELT $ 54))
                                              (QREFELT $ 55)))
                                       (LETT |nsl2| NIL)
                                       (LETT |noff| (+ (+ |nlvi| |nbas|) 1))
                                       (SEQ (LETT |j| 1) (LETT #18# |nrl|) G190
                                            (COND
                                             ((|greater_SI| |j| #18#)
                                              (GO G191)))
                                            (SEQ
                                             (LETT |ss| (|spadConstant| $ 8))
                                             (SEQ (LETT |slk| NIL)
                                                  (LETT #17# |nsl1|)
                                                  (LETT |k| |noff|) G190
                                                  (COND
                                                   ((OR (ATOM #17#)
                                                        (PROGN
                                                         (LETT |slk|
                                                               (CAR #17#))
                                                         NIL))
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |ss|
                                                          (SPADCALL |ss|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      |cm2| |j|
                                                                      |k|
                                                                      (QREFELT
                                                                       $ 56))
                                                                     |slk|
                                                                     (QREFELT $
                                                                              57))
                                                                    (QREFELT $
                                                                             35)))))
                                                  (LETT |k|
                                                        (PROG1 (+ |k| 1)
                                                          (LETT #17#
                                                                (CDR #17#))))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (LETT |nsl2|
                                                    (CONS |ss| |nsl2|))))
                                            (LETT |j| (|inc_SI| |j|)) (GO G190)
                                            G191 (EXIT NIL))
                                       (LETT |nrl1| 0)
                                       (SEQ
                                        (EXIT
                                         (SEQ (LETT |slj| NIL)
                                              (LETT #16# |nsl2|)
                                              (LETT |j| |nrl|) G190
                                              (COND
                                               ((OR (< |j| 1) (ATOM #16#)
                                                    (PROGN
                                                     (LETT |slj| (CAR #16#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (SEQ
                                                (EXIT
                                                 (SEQ (LETT |k| 1)
                                                      (LETT #15# |nlvi|) G190
                                                      (COND
                                                       ((|greater_SI| |k| #15#)
                                                        (GO G191)))
                                                      (SEQ
                                                       (EXIT
                                                        (COND
                                                         ((SPADCALL
                                                           (SPADCALL |cm2| |j|
                                                                     |k|
                                                                     (QREFELT $
                                                                              56))
                                                           (|spadConstant| $ 8)
                                                           (QREFELT $ 58))
                                                          (SEQ
                                                           (LETT |nrl1| |j|)
                                                           (EXIT
                                                            (PROGN
                                                             (LETT #14# 1)
                                                             (GO
                                                              #44=#:G819))))))))
                                                      (LETT |k| (|inc_SI| |k|))
                                                      (GO G190) G191
                                                      (EXIT NIL)))
                                                #44# (EXIT #14#))
                                               (EXIT
                                                (COND
                                                 ((SPADCALL |nrl1| 0
                                                            (QREFELT $ 20))
                                                  (PROGN
                                                   (LETT #13# 1)
                                                   (GO #45=#:G824)))
                                                 ('T
                                                  (SEQ
                                                   (LETT |nbcv|
                                                         (MAKEARR1 |nbas|
                                                                   (|spadConstant|
                                                                    $ 8)))
                                                   (SEQ (LETT |k| 1)
                                                        (LETT #12# |nbas|) G190
                                                        (COND
                                                         ((|greater_SI| |k|
                                                                        #12#)
                                                          (GO G191)))
                                                        (SEQ
                                                         (EXIT
                                                          (SPADCALL |nbcv| |k|
                                                                    (SPADCALL
                                                                     |cm2| |j|
                                                                     (+ |k|
                                                                        |nlvi|)
                                                                     (QREFELT $
                                                                              56))
                                                                    (QREFELT $
                                                                             40))))
                                                        (LETT |k|
                                                              (|inc_SI| |k|))
                                                        (GO G190) G191
                                                        (EXIT NIL))
                                                   (LETT |bv|
                                                         (SPADCALL |nbcv| |bvl|
                                                                   (QREFELT $
                                                                            59)))
                                                   (SPADCALL |bv| |i| |slj|
                                                             (QREFELT $ 40))
                                                   (EXIT
                                                    (LETT |nbvl|
                                                          (CONS |bv|
                                                                |nbvl|))))))))
                                              (LETT |j|
                                                    (PROG1 (+ |j| -1)
                                                      (LETT #16# (CDR #16#))))
                                              (GO G190) G191 (EXIT NIL)))
                                        #45# (EXIT #13#))
                                       (LETT |nsl2| (NREVERSE |nsl2|))
                                       (LETT |ncb| NIL) (LETT |ncba| NIL)
                                       (SEQ (LETT |slj| NIL) (LETT #11# |nsl2|)
                                            (LETT |j| 1) (LETT #10# |nrl1|)
                                            G190
                                            (COND
                                             ((OR (|greater_SI| |j| #10#)
                                                  (ATOM #11#)
                                                  (PROGN
                                                   (LETT |slj| (CAR #11#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (LETT |nbcv1|
                                                   (MAKEARR1 |nbas|
                                                             (|spadConstant| $
                                                                             8)))
                                             (SEQ (LETT |k| 1)
                                                  (LETT #9# |nbas|) G190
                                                  (COND
                                                   ((|greater_SI| |k| #9#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (SPADCALL |nbcv1| |k|
                                                              (SPADCALL |cm2|
                                                                        |j|
                                                                        (+ |k|
                                                                           |nlvi|)
                                                                        (QREFELT
                                                                         $ 56))
                                                              (QREFELT $ 40))))
                                                  (LETT |k| (|inc_SI| |k|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (LETT |nbcv2|
                                                   (MAKEARR1 |nlvi|
                                                             (|spadConstant| $
                                                                             8)))
                                             (SEQ (LETT |k| 1)
                                                  (LETT #8# |nlvi|) G190
                                                  (COND
                                                   ((|greater_SI| |k| #8#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (SPADCALL |nbcv2| |k|
                                                              (SPADCALL |cm2|
                                                                        |j| |k|
                                                                        (QREFELT
                                                                         $ 56))
                                                              (QREFELT $ 40))))
                                                  (LETT |k| (|inc_SI| |k|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (LETT |bv|
                                                   (SPADCALL |nbcv2| |cb|
                                                             (QREFELT $ 59)))
                                             (LETT |ncb| (CONS |bv| |ncb|))
                                             (LETT |na|
                                                   (SPADCALL |nbcv2| |cba|
                                                             (QREFELT $ 59)))
                                             (LETT |na|
                                                   (SPADCALL |nbcv1| |na| |bvl|
                                                             (QREFELT $ 60)))
                                             (SPADCALL |na| |i| |slj|
                                                       (QREFELT $ 40))
                                             (EXIT
                                              (LETT |ncba|
                                                    (CONS |na| |ncba|))))
                                            (LETT |j|
                                                  (PROG1 (|inc_SI| |j|)
                                                    (LETT #11# (CDR #11#))))
                                            (GO G190) G191 (EXIT NIL))
                                       (LETT |cb| (NREVERSE |ncb|))
                                       (LETT |cba| (NREVERSE |ncba|))
                                       (EXIT (LETT |bvl| |nbvl|)))))))
                                  (LETT |i| (+ |i| -1)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT
                              (CONS 0
                                    (CONS
                                     (PROGN
                                      (LETT #6# NIL)
                                      (SEQ (LETT #5# |cb|) (LETT |ba| NIL)
                                           (LETT #4# |cba|) G190
                                           (COND
                                            ((OR (ATOM #4#)
                                                 (PROGN
                                                  (LETT |ba| (CAR #4#))
                                                  NIL)
                                                 (ATOM #5#)
                                                 (PROGN
                                                  (LETT |bv| (CAR #5#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #6#
                                                   (CONS (CONS |ba| |bv|)
                                                         #6#))))
                                           (LETT #4#
                                                 (PROG1 (CDR #4#)
                                                   (LETT #5# (CDR #5#))))
                                           (GO G190) G191
                                           (EXIT (NREVERSE #6#))))
                                     |bvl|)))))))))
          #43# (EXIT #36#)))) 

(SDEFUN |OREMAT;solve;MFLMU;4|
        ((|m| (|Matrix| LO)) (|cc| (F)) (|lv| (|List| (|Vector| F)))
         (|solf|
          (|Mapping|
           (|Record|
            (|:| |particular|
                 (|List|
                  (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
            (|:| |basis| (|List| F)))
           LO (|List| F)))
         ($
          (|Union|
           (|Record|
            (|:| |particular|
                 (|List|
                  (|Record| (|:| |ratpart| (|Vector| F))
                            (|:| |coeffs| (|Vector| F)))))
            (|:| |basis| (|List| (|Vector| F))))
           "failed")))
        (SPROG
         ((|rec|
           (|Record| (|:| |mat| (|Matrix| LO))
                     (|:| |vecs| (|List| (|Vector| F))))))
         (SEQ (LETT |rec| (SPADCALL |m| |cc| |lv| (QREFELT $ 13)))
              (EXIT
               (|OREMAT;triangular_solve| (QCAR |rec|) |cc| (QCDR |rec|) |solf|
                $))))) 

(DECLAIM (NOTINLINE |OrePolynomialMatrixOperations;|)) 

(DEFUN |OrePolynomialMatrixOperations| (&REST #1=#:G892)
  (SPROG NIL
         (PROG (#2=#:G893)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|OrePolynomialMatrixOperations|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |OrePolynomialMatrixOperations;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|OrePolynomialMatrixOperations|)))))))))) 

(DEFUN |OrePolynomialMatrixOperations;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|OrePolynomialMatrixOperations| DV$1 DV$2))
          (LETT $ (GETREFV 68))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OrePolynomialMatrixOperations|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OrePolynomialMatrixOperations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |Zero|) (4 . |Zero|)
              (|Record| (|:| |mat| 11) (|:| |vecs| 12)) (|Matrix| 7)
              (|List| 16) |OREMAT;rowEchelon;MFLR;2| |OREMAT;rowEchelon;2M;1|
              (8 . |copy|) (|Vector| 6) (13 . |copy|) (|Boolean|)
              (|NonNegativeInteger|) (18 . ~=) (24 . |One|) (28 . |One|)
              (|Integer|) (32 . |elt|) (39 . |zero?|) (44 . |degree|)
              (49 . |swapRows!|) (|Void|) (56 . |swap!|)
              (|Record| (|:| |generator| $) (|:| |coef1| $) (|:| |coef2| $)
                        (|:| |coefu| $) (|:| |coefv| $))
              (63 . |right_ext_ext_GCD|) (69 . *) (75 . +) (81 . |apply|)
              (88 . +) (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (94 . |rightDivide|) (100 . -) (106 . -) (112 . |setelt!|)
              (119 . =) (125 . |elt|) (|List| 6)
              (|LinearCombinationUtilities| 6 (|SparseUnivariatePolynomial| 6))
              (131 . |lin_comb|) (137 . |concat|) (143 . |concat|)
              (149 . |parts|) (|List| 43) (|Matrix| 6) (154 . |matrix|)
              (159 . |scalarMatrix|) (165 . |scalarMatrix|)
              (171 . |horizConcat|) (177 . |rowEchelon|) (182 . |elt|)
              (189 . *) (195 . ~=) (201 . |lin_comb|) (207 . |lin_comb!|)
              (|Record| (|:| |ratpart| 16) (|:| |coeffs| 16))
              (|Record| (|:| |particular| (|List| 61)) (|:| |basis| 12))
              (|Union| 62 '#1="failed")
              (|Record| (|:| |ratpart| 6) (|:| |coeffs| 16))
              (|Record| (|:| |particular| (|List| 64)) (|:| |basis| 43))
              (|Mapping| 65 7 43) |OREMAT;solve;MFLMU;4|)
           '#(|solve| 214 |rowEchelon| 222) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rowEchelon|
                                 ((|Matrix| |#2|) (|Matrix| |#2|)))
                                T)
                              '((|rowEchelon|
                                 ((|Record| (|:| |mat| (|Matrix| |#2|))
                                            (|:| |vecs|
                                                 (|List| (|Vector| |#1|))))
                                  (|Matrix| |#2|) |#1|
                                  (|List| (|Vector| |#1|))))
                                T)
                              '((|solve|
                                 ((|Union|
                                   (|Record|
                                    (|:| |particular|
                                         (|List|
                                          (|Record|
                                           (|:| |ratpart| (|Vector| |#1|))
                                           (|:| |coeffs| (|Vector| |#1|)))))
                                    (|:| |basis| (|List| (|Vector| |#1|))))
                                   #1#)
                                  (|Matrix| |#2|) |#1| (|List| (|Vector| |#1|))
                                  (|Mapping|
                                   (|Record|
                                    (|:| |particular|
                                         (|List|
                                          (|Record| (|:| |ratpart| |#1|)
                                                    (|:| |coeffs|
                                                         (|Vector| |#1|)))))
                                    (|:| |basis| (|List| |#1|)))
                                   |#2| (|List| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 67
                                            '(0 6 0 8 0 7 0 9 1 11 0 0 15 1 16
                                              0 0 17 2 19 18 0 0 20 0 6 0 21 0
                                              7 0 22 3 11 7 0 23 23 24 1 7 18 0
                                              25 1 7 19 0 26 3 11 0 0 23 23 27
                                              3 16 28 0 23 23 29 2 7 30 0 0 31
                                              2 7 0 0 0 32 2 7 0 0 0 33 3 7 6 0
                                              6 6 34 2 6 0 0 0 35 2 7 36 0 0 37
                                              2 7 0 0 0 38 2 6 0 0 0 39 3 16 6
                                              0 23 6 40 2 7 18 0 0 41 2 16 6 0
                                              23 42 2 44 6 16 43 45 2 43 0 0 0
                                              46 2 12 0 0 0 47 1 16 43 0 48 1
                                              50 0 49 51 2 11 0 19 7 52 2 50 0
                                              19 6 53 2 50 0 0 0 54 1 50 0 0 55
                                              3 50 6 0 23 23 56 2 6 0 0 0 57 2
                                              6 18 0 0 58 2 44 16 16 12 59 3 44
                                              16 16 16 12 60 4 0 63 11 6 12 66
                                              67 1 0 11 11 14 3 0 10 11 6 12
                                              13)))))
           '|lookupComplete|)) 
