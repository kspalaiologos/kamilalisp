
(SDEFUN |NUMODE;rk4a;VI4FIMV;1|
        ((|ystart| (|Vector| (|Float|))) (|nvar| #1=(|Integer|))
         (|x1| #2=(|Float|)) (|x2| (|Float|)) (|eps| (|Float|))
         (|htry| (|Float|)) (|nstep| (|Integer|))
         (|derivs|
          (|Mapping| (|Void|) (|Vector| (|Float|)) (|Vector| (|Float|))
                     (|Float|)))
         ($ (|Void|)))
        (SPROG
         ((#3=#:G759 NIL) (|i| NIL) (#4=#:G755 NIL) (|x| #2#) (#5=#:G758 NIL)
          (#6=#:G757 NIL) (|iter| NIL) (#7=#:G756 NIL)
          (|outlist| (|List| (|OutputForm|))) (|m| #1#) (|tiny| (|Float|))
          (|step|
           (|Record| (|:| |to_try| (|Float|)) (|:| |did| (|Float|))
                     (|:| |next| (|Float|))))
          (|t6| #8=(|Vector| (|Float|))) (#9=#:G716 NIL) (|t5| #8#)
          (#10=#:G714 NIL) (|t4| #8#) (#11=#:G712 NIL) (|t3| #8#)
          (#12=#:G710 NIL) (|t2| #8#) (#13=#:G708 NIL) (|t1| #8#)
          (#14=#:G706 NIL) (|dydx| #8#) (#15=#:G704 NIL) (|yscal| #8#)
          (#16=#:G702 NIL) (|y| #8#) (#17=#:G699 NIL))
         (SEQ
          (LETT |y|
                (MAKEARR1
                 (PROG1 (LETT #17# |nvar|)
                   (|check_subtype2| (>= #17# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #17#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |yscal|
                (MAKEARR1
                 (PROG1 (LETT #16# |nvar|)
                   (|check_subtype2| (>= #16# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #16#))
                 (SPADCALL 1 0 10 (QREFELT $ 10))))
          (LETT |dydx|
                (MAKEARR1
                 (PROG1 (LETT #15# |nvar|)
                   (|check_subtype2| (>= #15# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #15#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t1|
                (MAKEARR1
                 (PROG1 (LETT #14# |nvar|)
                   (|check_subtype2| (>= #14# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #14#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t2|
                (MAKEARR1
                 (PROG1 (LETT #13# |nvar|)
                   (|check_subtype2| (>= #13# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #13#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t3|
                (MAKEARR1
                 (PROG1 (LETT #12# |nvar|)
                   (|check_subtype2| (>= #12# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #12#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t4|
                (MAKEARR1
                 (PROG1 (LETT #11# |nvar|)
                   (|check_subtype2| (>= #11# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #11#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t5|
                (MAKEARR1
                 (PROG1 (LETT #10# |nvar|)
                   (|check_subtype2| (>= #10# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #10#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t6|
                (MAKEARR1
                 (PROG1 (LETT #9# |nvar|)
                   (|check_subtype2| (>= #9# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #9#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |step|
                (VECTOR |htry| (SPADCALL 0 0 10 (QREFELT $ 10))
                        (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |x| |x1|)
          (LETT |tiny|
                (SPADCALL (SPADCALL 10 0 10 (QREFELT $ 10))
                          (- (+ (SPADCALL (QREFELT $ 12)) 1)) (QREFELT $ 13)))
          (LETT |m| |nvar|)
          (LETT |outlist|
                (LIST (SPADCALL |x| (QREFELT $ 15))
                      (SPADCALL |x| (QREFELT $ 15))
                      (SPADCALL |x| (QREFELT $ 15))))
          (LETT |eps|
                (SPADCALL (SPADCALL 1 0 10 (QREFELT $ 10)) |eps|
                          (QREFELT $ 16)))
          (SEQ (LETT |i| 1) (LETT #7# |m|) G190
               (COND ((|greater_SI| |i| #7#) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |y| |i| (SPADCALL |ystart| |i| (QREFELT $ 18))
                           (QREFELT $ 19))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (SEQ
           (EXIT
            (SEQ (LETT |iter| 1) (LETT #6# |nstep|) G190
                 (COND ((|greater_SI| |iter| #6#) (GO G191)))
                 (SEQ (SPADCALL |dydx| |y| |x| |derivs|)
                      (COND
                       ((SPADCALL
                         (SPADCALL
                          (SPADCALL |x| (QVELT |step| 0) (QREFELT $ 20)) |x2|
                          (QREFELT $ 21))
                         (SPADCALL 0 0 10 (QREFELT $ 10)) (QREFELT $ 23))
                        (QSETVELT |step| 0
                                  (SPADCALL |x2| |x| (QREFELT $ 21)))))
                      (SEQ (LETT |i| 1) (LETT #5# |m|) G190
                           (COND ((|greater_SI| |i| #5#) (GO G191)))
                           (SEQ
                            (EXIT
                             (SPADCALL |yscal| |i|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |y| |i| (QREFELT $ 18))
                                          (QREFELT $ 24))
                                         (SPADCALL
                                          (SPADCALL (QVELT |step| 0)
                                                    (SPADCALL |dydx| |i|
                                                              (QREFELT $ 18))
                                                    (QREFELT $ 25))
                                          (QREFELT $ 24))
                                         (QREFELT $ 20))
                                        |tiny| (QREFELT $ 20))
                                       (QREFELT $ 19))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (|NUMODE;rk4qclocal| |y| |dydx| |nvar| |x| |step| |eps|
                       |yscal| |derivs| |t1| |t2| |t3| |t4| |t5| |t6| $)
                      (LETT |x| (SPADCALL |x| (QVELT |step| 1) (QREFELT $ 20)))
                      (COND
                       ((SPADCALL (SPADCALL |x| |x2| (QREFELT $ 21))
                                  (SPADCALL 0 0 10 (QREFELT $ 10))
                                  (QREFELT $ 26))
                        (PROGN (LETT #4# 1) (GO #18=#:G739))))
                      (EXIT (QSETVELT |step| 0 (QVELT |step| 2))))
                 (LETT |iter| (|inc_SI| |iter|)) (GO G190) G191 (EXIT NIL)))
           #18# (EXIT #4#))
          (COND
           ((EQL |iter| (+ |nstep| 1))
            (SEQ (SPADCALL "ode: ERROR " (QREFELT $ 30))
                 (SPADCALL |outlist| 1 (SPADCALL |nstep| (QREFELT $ 31))
                           (QREFELT $ 33))
                 (SPADCALL |outlist| 2
                           (SPADCALL " steps to small, last h = "
                                     (QREFELT $ 34))
                           (QREFELT $ 33))
                 (SPADCALL |outlist| 3
                           (SPADCALL (QVELT |step| 1) (QREFELT $ 15))
                           (QREFELT $ 33))
                 (SPADCALL (SPADCALL |outlist| (QREFELT $ 36)) (QREFELT $ 37))
                 (EXIT
                  (SPADCALL " y= " (SPADCALL |y| (QREFELT $ 38))
                            (QREFELT $ 39))))))
          (EXIT
           (SEQ (LETT |i| 1) (LETT #3# |m|) G190
                (COND ((|greater_SI| |i| #3#) (GO G191)))
                (SEQ
                 (EXIT
                  (SPADCALL |ystart| |i| (SPADCALL |y| |i| (QREFELT $ 18))
                            (QREFELT $ 19))))
                (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |NUMODE;rk4qc;VIFRFVMV;2|
        ((|y| (|Vector| (|Float|))) (|n| (|Integer|)) (|x| (|Float|))
         (|step|
          (|Record| (|:| |to_try| (|Float|)) (|:| |did| (|Float|))
                    (|:| |next| (|Float|))))
         (|eps| (|Float|)) (|yscal| (|Vector| (|Float|)))
         (|derivs|
          (|Mapping| (|Void|) (|Vector| (|Float|)) (|Vector| (|Float|))
                     (|Float|)))
         ($ (|Void|)))
        (SPROG
         ((|t7| #1=(|Vector| (|Float|))) (#2=#:G774 NIL) (|t6| #1#)
          (#3=#:G772 NIL) (|t5| #1#) (#4=#:G770 NIL) (|t4| #1#) (#5=#:G768 NIL)
          (|t3| #1#) (#6=#:G766 NIL) (|t2| #1#) (#7=#:G764 NIL) (|t1| #1#)
          (#8=#:G762 NIL))
         (SEQ
          (LETT |t1|
                (MAKEARR1
                 (PROG1 (LETT #8# |n|)
                   (|check_subtype2| (>= #8# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #8#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t2|
                (MAKEARR1
                 (PROG1 (LETT #7# |n|)
                   (|check_subtype2| (>= #7# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #7#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t3|
                (MAKEARR1
                 (PROG1 (LETT #6# |n|)
                   (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #6#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t4|
                (MAKEARR1
                 (PROG1 (LETT #5# |n|)
                   (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #5#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t5|
                (MAKEARR1
                 (PROG1 (LETT #4# |n|)
                   (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #4#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t6|
                (MAKEARR1
                 (PROG1 (LETT #3# |n|)
                   (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #3#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t7|
                (MAKEARR1
                 (PROG1 (LETT #2# |n|)
                   (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #2#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (SPADCALL |t7| |y| |x| |derivs|)
          (LETT |eps|
                (SPADCALL (SPADCALL 1 0 10 (QREFELT $ 10)) |eps|
                          (QREFELT $ 16)))
          (EXIT
           (|NUMODE;rk4qclocal| |y| |t7| |n| |x| |step| |eps| |yscal| |derivs|
            |t1| |t2| |t3| |t4| |t5| |t6| $))))) 

(SDEFUN |NUMODE;rk4qc;VIFRFVM7VV;3|
        ((|y| (|Vector| (|Float|))) (|n| (|Integer|)) (|x| (|Float|))
         (|step|
          (|Record| (|:| |to_try| (|Float|)) (|:| |did| (|Float|))
                    (|:| |next| (|Float|))))
         (|eps| (|Float|)) (|yscal| (|Vector| (|Float|)))
         (|derivs|
          (|Mapping| (|Void|) (|Vector| (|Float|)) (|Vector| (|Float|))
                     (|Float|)))
         (|t1| (|Vector| (|Float|))) (|t2| (|Vector| (|Float|)))
         (|t3| (|Vector| (|Float|))) (|t4| (|Vector| (|Float|)))
         (|t5| (|Vector| (|Float|))) (|t6| (|Vector| (|Float|)))
         (|dydx| (|Vector| (|Float|))) ($ (|Void|)))
        (SEQ (SPADCALL |dydx| |y| |x| |derivs|)
             (LETT |eps|
                   (SPADCALL (SPADCALL 1 0 10 (QREFELT $ 10)) |eps|
                             (QREFELT $ 16)))
             (EXIT
              (|NUMODE;rk4qclocal| |y| |dydx| |n| |x| |step| |eps| |yscal|
               |derivs| |t1| |t2| |t3| |t4| |t5| |t6| $)))) 

(SDEFUN |NUMODE;rk4qclocal|
        ((|y| (|Vector| (|Float|))) (|dydx| (|Vector| (|Float|)))
         (|n| #1=(|Integer|)) (|x| #2=(|Float|))
         (|step|
          (|Record| (|:| |to_try| #3=(|Float|)) (|:| |did| (|Float|))
                    (|:| |next| (|Float|))))
         (|eps| (|Float|)) (|yscal| (|Vector| (|Float|)))
         (|derivs|
          (|Mapping| (|Void|) (|Vector| (|Float|)) (|Vector| (|Float|))
                     (|Float|)))
         (|t1| (|Vector| (|Float|))) (|t2| (|Vector| (|Float|)))
         (|t3| (|Vector| (|Float|))) (|ysav| (|Vector| (|Float|)))
         (|dysav| (|Vector| (|Float|))) (|ytemp| (|Vector| (|Float|)))
         ($ (|Void|)))
        (SPROG
         ((#4=#:G814 NIL) (|i| NIL) (#5=#:G811 NIL) (|h| #3#)
          (|errmax| #6=(|Float|)) (#7=#:G813 NIL) (|hh| (|Float|))
          (#8=#:G812 NIL) (|m| #1#) (|errcon| #6#) (|shrink| #9=(|Float|))
          (|grow| #9#) (|safety| #6#) (|fcor| (|Float|)) (|xsav| #2#))
         (SEQ (LETT |xsav| |x|) (LETT |h| (QVELT |step| 0))
              (LETT |fcor|
                    (SPADCALL (SPADCALL 1 0 10 (QREFELT $ 10))
                              (SPADCALL 15 0 10 (QREFELT $ 10))
                              (QREFELT $ 16)))
              (LETT |safety| (SPADCALL 9 -1 10 (QREFELT $ 10)))
              (LETT |grow|
                    (SPADCALL (SPADCALL 20 -2 10 (QREFELT $ 10))
                              (QREFELT $ 45)))
              (LETT |shrink|
                    (SPADCALL (SPADCALL 25 -2 10 (QREFELT $ 10))
                              (QREFELT $ 45)))
              (LETT |errcon| (SPADCALL 6 -5 10 (QREFELT $ 10))) (LETT |m| |n|)
              (SEQ (LETT |i| 1) (LETT #8# |m|) G190
                   (COND ((|greater_SI| |i| #8#) (GO G191)))
                   (SEQ
                    (SPADCALL |dysav| |i| (SPADCALL |dydx| |i| (QREFELT $ 18))
                              (QREFELT $ 19))
                    (EXIT
                     (SPADCALL |ysav| |i| (SPADCALL |y| |i| (QREFELT $ 18))
                               (QREFELT $ 19))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SEQ
               (EXIT
                (SEQ G190 NIL
                     (SEQ
                      (LETT |hh|
                            (SPADCALL (SPADCALL 5 -1 10 (QREFELT $ 10)) |h|
                                      (QREFELT $ 25)))
                      (|NUMODE;rk4local| |ysav| |dysav| |n| |xsav| |hh| |ytemp|
                       |derivs| |t1| |t2| |t3| $)
                      (LETT |x| (SPADCALL |xsav| |hh| (QREFELT $ 20)))
                      (SPADCALL |dydx| |ytemp| |x| |derivs|)
                      (|NUMODE;rk4local| |ytemp| |dydx| |n| |x| |hh| |y|
                       |derivs| |t1| |t2| |t3| $)
                      (LETT |x| (SPADCALL |xsav| |h| (QREFELT $ 20)))
                      (|NUMODE;rk4local| |ysav| |dysav| |n| |xsav| |h| |ytemp|
                       |derivs| |t1| |t2| |t3| $)
                      (LETT |errmax| (SPADCALL 0 0 10 (QREFELT $ 10)))
                      (SEQ (LETT |i| 1) (LETT #7# |m|) G190
                           (COND ((|greater_SI| |i| #7#) (GO G191)))
                           (SEQ
                            (SPADCALL |ytemp| |i|
                                      (SPADCALL
                                       (SPADCALL |y| |i| (QREFELT $ 18))
                                       (SPADCALL |ytemp| |i| (QREFELT $ 18))
                                       (QREFELT $ 21))
                                      (QREFELT $ 19))
                            (EXIT
                             (LETT |errmax|
                                   (SPADCALL |errmax|
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL |ytemp| |i|
                                                         (QREFELT $ 18))
                                               (SPADCALL |yscal| |i|
                                                         (QREFELT $ 18))
                                               (QREFELT $ 16))
                                              (QREFELT $ 24))
                                             (QREFELT $ 46)))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (LETT |errmax| (SPADCALL |errmax| |eps| (QREFELT $ 25)))
                      (EXIT
                       (COND
                        ((SPADCALL |errmax| (SPADCALL 1 0 10 (QREFELT $ 10))
                                   (QREFELT $ 23))
                         (LETT |h|
                               (SPADCALL (SPADCALL |safety| |h| (QREFELT $ 25))
                                         (SPADCALL |errmax| |shrink|
                                                   (QREFELT $ 47))
                                         (QREFELT $ 25))))
                        ('T
                         (SEQ (QSETVELT |step| 1 |h|)
                              (COND
                               ((SPADCALL |errmax| |errcon| (QREFELT $ 23))
                                (QSETVELT |step| 2
                                          (SPADCALL
                                           (SPADCALL |safety| |h|
                                                     (QREFELT $ 25))
                                           (SPADCALL |errmax| |grow|
                                                     (QREFELT $ 47))
                                           (QREFELT $ 25))))
                               ('T
                                (QSETVELT |step| 2
                                          (SPADCALL 4 |h| (QREFELT $ 48)))))
                              (EXIT (PROGN (LETT #5# 1) (GO #10=#:G806))))))))
                     NIL (GO G190) G191 (EXIT NIL)))
               #10# (EXIT #5#))
              (EXIT
               (SEQ (LETT |i| 1) (LETT #4# |m|) G190
                    (COND ((|greater_SI| |i| #4#) (GO G191)))
                    (SEQ
                     (EXIT
                      (SPADCALL |y| |i|
                                (SPADCALL (SPADCALL |y| |i| (QREFELT $ 18))
                                          (SPADCALL
                                           (SPADCALL |ytemp| |i|
                                                     (QREFELT $ 18))
                                           |fcor| (QREFELT $ 25))
                                          (QREFELT $ 20))
                                (QREFELT $ 19))))
                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |NUMODE;rk4f;VI2FIMV;5|
        ((|y| (|Vector| (|Float|))) (|nvar| (|Integer|)) (|x1| #1=(|Float|))
         (|x2| (|Float|)) (|nstep| (|Integer|))
         (|derivs|
          (|Mapping| (|Void|) (|Vector| (|Float|)) (|Vector| (|Float|))
                     (|Float|)))
         ($ (|Void|)))
        (SPROG
         ((|x| #1#) (#2=#:G831 NIL) (|i| NIL) (|h| (|Float|))
          (|dydx| #3=(|Vector| (|Float|))) (#4=#:G822 NIL) (|dym| #3#)
          (#5=#:G820 NIL) (|dyt| #3#) (#6=#:G818 NIL) (|yt| #3#)
          (#7=#:G816 NIL))
         (SEQ
          (LETT |yt|
                (MAKEARR1
                 (PROG1 (LETT #7# |nvar|)
                   (|check_subtype2| (>= #7# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #7#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |dyt|
                (MAKEARR1
                 (PROG1 (LETT #6# |nvar|)
                   (|check_subtype2| (>= #6# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #6#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |dym|
                (MAKEARR1
                 (PROG1 (LETT #5# |nvar|)
                   (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #5#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |dydx|
                (MAKEARR1
                 (PROG1 (LETT #4# |nvar|)
                   (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #4#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |h|
                (SPADCALL (SPADCALL |x2| |x1| (QREFELT $ 21))
                          (SPADCALL |nstep| (QREFELT $ 49)) (QREFELT $ 16)))
          (LETT |x| |x1|)
          (EXIT
           (SEQ (LETT |i| 1) (LETT #2# |nstep|) G190
                (COND ((|greater_SI| |i| #2#) (GO G191)))
                (SEQ (SPADCALL |dydx| |y| |x| |derivs|)
                     (|NUMODE;rk4local| |y| |dydx| |nvar| |x| |h| |y| |derivs|
                      |yt| |dyt| |dym| $)
                     (EXIT (LETT |x| (SPADCALL |x| |h| (QREFELT $ 20)))))
                (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |NUMODE;rk4;VI2FMV;6|
        ((|y| (|Vector| (|Float|))) (|n| (|Integer|)) (|x| (|Float|))
         (|h| (|Float|))
         (|derivs|
          (|Mapping| (|Void|) (|Vector| (|Float|)) (|Vector| (|Float|))
                     (|Float|)))
         ($ (|Void|)))
        (SPROG
         ((|t4| #1=(|Vector| (|Float|))) (#2=#:G839 NIL) (|t3| #1#)
          (#3=#:G837 NIL) (|t2| #1#) (#4=#:G835 NIL) (|t1| #1#)
          (#5=#:G833 NIL))
         (SEQ
          (LETT |t1|
                (MAKEARR1
                 (PROG1 (LETT #5# |n|)
                   (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #5#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t2|
                (MAKEARR1
                 (PROG1 (LETT #4# |n|)
                   (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #4#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t3|
                (MAKEARR1
                 (PROG1 (LETT #3# |n|)
                   (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #3#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (LETT |t4|
                (MAKEARR1
                 (PROG1 (LETT #2# |n|)
                   (|check_subtype2| (>= #2# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #2#))
                 (SPADCALL 0 0 10 (QREFELT $ 10))))
          (SPADCALL |t1| |y| |x| |derivs|)
          (EXIT
           (|NUMODE;rk4local| |y| |t1| |n| |x| |h| |y| |derivs| |t2| |t3| |t4|
            $))))) 

(SDEFUN |NUMODE;rk4;VI2FM4VV;7|
        ((|y| (|Vector| (|Float|))) (|n| (|Integer|)) (|x| (|Float|))
         (|h| (|Float|))
         (|derivs|
          (|Mapping| (|Void|) (|Vector| (|Float|)) (|Vector| (|Float|))
                     (|Float|)))
         (|t1| (|Vector| (|Float|))) (|t2| (|Vector| (|Float|)))
         (|t3| (|Vector| (|Float|))) (|t4| (|Vector| (|Float|))) ($ (|Void|)))
        (SEQ (SPADCALL |t1| |y| |x| |derivs|)
             (EXIT
              (|NUMODE;rk4local| |y| |t1| |n| |x| |h| |y| |derivs| |t2| |t3|
               |t4| $)))) 

(SDEFUN |NUMODE;rk4local|
        ((|y| (|Vector| (|Float|))) (|dydx| (|Vector| (|Float|)))
         (|n| #1=(|Integer|)) (|x| (|Float|)) (|h| (|Float|))
         (|yout| (|Vector| (|Float|)))
         (|derivs|
          (|Mapping| (|Void|) (|Vector| (|Float|)) (|Vector| (|Float|))
                     (|Float|)))
         (|yt| (|Vector| (|Float|))) (|dyt| (|Vector| (|Float|)))
         (|dym| (|Vector| (|Float|))) ($ (|Void|)))
        (SPROG
         ((#2=#:G864 NIL) (|i| NIL) (#3=#:G863 NIL) (#4=#:G862 NIL)
          (#5=#:G861 NIL) (|m| #1#) (|xh| (|Float|)) (|h6| (|Float|))
          (|hh| (|Float|)))
         (SEQ
          (LETT |hh|
                (SPADCALL |h| (SPADCALL 5 -1 10 (QREFELT $ 10))
                          (QREFELT $ 25)))
          (LETT |h6|
                (SPADCALL |h| (SPADCALL 6 0 10 (QREFELT $ 10)) (QREFELT $ 16)))
          (LETT |xh| (SPADCALL |x| |hh| (QREFELT $ 20))) (LETT |m| |n|)
          (SEQ (LETT |i| 1) (LETT #5# |m|) G190
               (COND ((|greater_SI| |i| #5#) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |yt| |i|
                           (SPADCALL (SPADCALL |y| |i| (QREFELT $ 18))
                                     (SPADCALL |hh|
                                               (SPADCALL |dydx| |i|
                                                         (QREFELT $ 18))
                                               (QREFELT $ 25))
                                     (QREFELT $ 20))
                           (QREFELT $ 19))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (SPADCALL |dyt| |yt| |xh| |derivs|)
          (SEQ (LETT |i| 1) (LETT #4# |m|) G190
               (COND ((|greater_SI| |i| #4#) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |yt| |i|
                           (SPADCALL (SPADCALL |y| |i| (QREFELT $ 18))
                                     (SPADCALL |hh|
                                               (SPADCALL |dyt| |i|
                                                         (QREFELT $ 18))
                                               (QREFELT $ 25))
                                     (QREFELT $ 20))
                           (QREFELT $ 19))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (SPADCALL |dym| |yt| |xh| |derivs|)
          (SEQ (LETT |i| 1) (LETT #3# |m|) G190
               (COND ((|greater_SI| |i| #3#) (GO G191)))
               (SEQ
                (SPADCALL |yt| |i|
                          (SPADCALL (SPADCALL |y| |i| (QREFELT $ 18))
                                    (SPADCALL |h|
                                              (SPADCALL |dym| |i|
                                                        (QREFELT $ 18))
                                              (QREFELT $ 25))
                                    (QREFELT $ 20))
                          (QREFELT $ 19))
                (EXIT
                 (SPADCALL |dym| |i|
                           (SPADCALL (SPADCALL |dyt| |i| (QREFELT $ 18))
                                     (SPADCALL |dym| |i| (QREFELT $ 18))
                                     (QREFELT $ 20))
                           (QREFELT $ 19))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (SPADCALL |dyt| |yt| (SPADCALL |x| |h| (QREFELT $ 20)) |derivs|)
          (EXIT
           (SEQ (LETT |i| 1) (LETT #2# |m|) G190
                (COND ((|greater_SI| |i| #2#) (GO G191)))
                (SEQ
                 (EXIT
                  (SPADCALL |yout| |i|
                            (SPADCALL (SPADCALL |y| |i| (QREFELT $ 18))
                                      (SPADCALL |h6|
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL |dydx| |i|
                                                            (QREFELT $ 18))
                                                  (SPADCALL
                                                   (SPADCALL 2 0 10
                                                             (QREFELT $ 10))
                                                   (SPADCALL |dym| |i|
                                                             (QREFELT $ 18))
                                                   (QREFELT $ 25))
                                                  (QREFELT $ 20))
                                                 (SPADCALL |dyt| |i|
                                                           (QREFELT $ 18))
                                                 (QREFELT $ 20))
                                                (QREFELT $ 25))
                                      (QREFELT $ 20))
                            (QREFELT $ 19))))
                (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))) 

(DECLAIM (NOTINLINE |NumericalOrdinaryDifferentialEquations;|)) 

(DEFUN |NumericalOrdinaryDifferentialEquations| ()
  (SPROG NIL
         (PROG (#1=#:G866)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache|
                          '|NumericalOrdinaryDifferentialEquations|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|NumericalOrdinaryDifferentialEquations|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|NumericalOrdinaryDifferentialEquations;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|NumericalOrdinaryDifferentialEquations|)))))))))) 

(DEFUN |NumericalOrdinaryDifferentialEquations;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|NumericalOrdinaryDifferentialEquations|))
          (LETT $ (GETREFV 53))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|NumericalOrdinaryDifferentialEquations| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|NumericalOrdinaryDifferentialEquations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Float|) (0 . |Zero|) (|Integer|)
              (|PositiveInteger|) (4 . |float|) (11 . |One|) (15 . |digits|)
              (19 . ^) (|OutputForm|) (25 . |coerce|) (30 . /) (|Vector| 6)
              (36 . |elt|) (42 . |setelt!|) (49 . +) (55 . -) (|Boolean|)
              (61 . >) (67 . |abs|) (72 . *) (78 . >=) (|Void|) (|String|)
              (|OutputPackage|) (84 . |output|) (89 . |coerce|) (|List| 14)
              (94 . |setelt!|) (101 . |coerce|) (|List| $)
              (106 . |blankSeparate|) (111 . |output|) (116 . |coerce|)
              (121 . |output|) (|Mapping| 27 17 17 6) |NUMODE;rk4a;VI4FIMV;1|
              (|Record| (|:| |to_try| 6) (|:| |did| 6) (|:| |next| 6))
              |NUMODE;rk4qc;VIFRFVMV;2| |NUMODE;rk4qc;VIFRFVM7VV;3| (127 . -)
              (132 . |max|) (138 . ^) (144 . *) (150 . |coerce|)
              |NUMODE;rk4f;VI2FIMV;5| |NUMODE;rk4;VI2FMV;6|
              |NUMODE;rk4;VI2FM4VV;7|)
           '#(|rk4qc| 155 |rk4f| 184 |rk4a| 194 |rk4| 206) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rk4|
                                 ((|Void|) (|Vector| (|Float|)) (|Integer|)
                                  (|Float|) (|Float|)
                                  (|Mapping| (|Void|) (|Vector| (|Float|))
                                             (|Vector| (|Float|)) (|Float|))))
                                T)
                              '((|rk4|
                                 ((|Void|) (|Vector| (|Float|)) (|Integer|)
                                  (|Float|) (|Float|)
                                  (|Mapping| (|Void|) (|Vector| (|Float|))
                                             (|Vector| (|Float|)) (|Float|))
                                  (|Vector| (|Float|)) (|Vector| (|Float|))
                                  (|Vector| (|Float|)) (|Vector| (|Float|))))
                                T)
                              '((|rk4a|
                                 ((|Void|) (|Vector| (|Float|)) (|Integer|)
                                  (|Float|) (|Float|) (|Float|) (|Float|)
                                  (|Integer|)
                                  (|Mapping| (|Void|) (|Vector| (|Float|))
                                             (|Vector| (|Float|)) (|Float|))))
                                T)
                              '((|rk4qc|
                                 ((|Void|) (|Vector| (|Float|)) (|Integer|)
                                  (|Float|)
                                  (|Record| (|:| |to_try| (|Float|))
                                            (|:| |did| (|Float|))
                                            (|:| |next| (|Float|)))
                                  (|Float|) (|Vector| (|Float|))
                                  (|Mapping| (|Void|) (|Vector| (|Float|))
                                             (|Vector| (|Float|)) (|Float|))))
                                T)
                              '((|rk4qc|
                                 ((|Void|) (|Vector| (|Float|)) (|Integer|)
                                  (|Float|)
                                  (|Record| (|:| |to_try| (|Float|))
                                            (|:| |did| (|Float|))
                                            (|:| |next| (|Float|)))
                                  (|Float|) (|Vector| (|Float|))
                                  (|Mapping| (|Void|) (|Vector| (|Float|))
                                             (|Vector| (|Float|)) (|Float|))
                                  (|Vector| (|Float|)) (|Vector| (|Float|))
                                  (|Vector| (|Float|)) (|Vector| (|Float|))
                                  (|Vector| (|Float|)) (|Vector| (|Float|))
                                  (|Vector| (|Float|))))
                                T)
                              '((|rk4f|
                                 ((|Void|) (|Vector| (|Float|)) (|Integer|)
                                  (|Float|) (|Float|) (|Integer|)
                                  (|Mapping| (|Void|) (|Vector| (|Float|))
                                             (|Vector| (|Float|)) (|Float|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 52
                                            '(0 6 0 7 3 6 0 8 8 9 10 0 6 0 11 0
                                              6 9 12 2 6 0 0 8 13 1 6 14 0 15 2
                                              6 0 0 0 16 2 17 6 0 8 18 3 17 6 0
                                              8 6 19 2 6 0 0 0 20 2 6 0 0 0 21
                                              2 6 22 0 0 23 1 6 0 0 24 2 6 0 0
                                              0 25 2 6 22 0 0 26 1 29 27 28 30
                                              1 8 14 0 31 3 32 14 0 8 14 33 1
                                              28 14 0 34 1 14 0 35 36 1 29 27
                                              14 37 1 17 14 0 38 2 29 27 28 14
                                              39 1 6 0 0 45 2 6 0 0 0 46 2 6 0
                                              0 0 47 2 6 0 9 0 48 1 6 0 8 49 7
                                              0 27 17 8 6 42 6 17 40 43 14 0 27
                                              17 8 6 42 6 17 40 17 17 17 17 17
                                              17 17 44 6 0 27 17 8 6 6 8 40 50
                                              8 0 27 17 8 6 6 6 6 8 40 41 5 0
                                              27 17 8 6 6 40 51 9 0 27 17 8 6 6
                                              40 17 17 17 17 52)))))
           '|lookupComplete|)) 

(MAKEPROP '|NumericalOrdinaryDifferentialEquations| 'NILADIC T) 
