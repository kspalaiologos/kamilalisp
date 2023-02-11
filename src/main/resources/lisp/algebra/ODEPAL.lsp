
(SDEFUN |ODEPAL;rat_solve|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|lf| (|List| (|Fraction| UP)))
         ($
          (|Record|
           (|:| |particular|
                (|List|
                 (|Record| (|:| |ratpart| (|Fraction| UP))
                           (|:| |coeffs| (|Vector| (|Fraction| UP))))))
           (|:| |basis| (|List| (|Fraction| UP))))))
        (SPROG
         ((|bl| (|List| (|Fraction| UP))) (|s| (|Fraction| UP)) (#1=#:G742 NIL)
          (|k| NIL) (#2=#:G743 NIL) (|bf| NIL) (#3=#:G741 NIL) (|i| NIL)
          (|sl|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| UP))
                      (|:| |coeffs| (|Vector| (|Fraction| UP))))))
          (#4=#:G739 NIL) (#5=#:G740 NIL) (#6=#:G738 NIL)
          (|cv| (|Vector| (|Fraction| UP))) (#7=#:G734 NIL) (|i0| (|Integer|))
          (|j| (|Integer|)) (#8=#:G737 NIL) (|nr| (|NonNegativeInteger|))
          (|m3| (|Matrix| F)) (|nc| (|NonNegativeInteger|))
          (|nn| #9=(|NonNegativeInteger|)) (|m1| (|Matrix| F)) (#10=#:G736 NIL)
          (|kv| NIL) (#11=#:G735 NIL) (|nb| #9#) (|ker| (|List| (|Vector| F)))
          (|bas| #12=(|List| (|Fraction| UP)))
          (|sol| (|Record| (|:| |basis| #12#) (|:| |mat| (|Matrix| F)))))
         (SEQ (LETT |sol| (SPADCALL |l| |lf| (QREFELT $ 14)))
              (LETT |bas| (QCAR |sol|))
              (LETT |ker| (SPADCALL (QCDR |sol|) (QREFELT $ 19)))
              (EXIT
               (COND ((NULL |ker|) (CONS NIL NIL))
                     ('T
                      (SEQ (LETT |nn| (LENGTH |lf|)) (LETT |nb| (LENGTH |bas|))
                           (COND
                            ((SPADCALL |nb| (ANCOLS (QCDR |sol|))
                                       (QREFELT $ 22))
                             (|error| "rat_solve: nb ~= ncols(sol.mat)")))
                           (LETT |m1|
                                 (SPADCALL
                                  (PROGN
                                   (LETT #11# NIL)
                                   (SEQ (LETT |kv| NIL) (LETT #10# |ker|) G190
                                        (COND
                                         ((OR (ATOM #10#)
                                              (PROGN
                                               (LETT |kv| (CAR #10#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #11#
                                                (CONS
                                                 (SPADCALL |kv| (QREFELT $ 25))
                                                 #11#))))
                                        (LETT #10# (CDR #10#)) (GO G190) G191
                                        (EXIT (NREVERSE #11#))))
                                  (QREFELT $ 27)))
                           (LETT |nn| (LENGTH |lf|)) (LETT |nc| (ANCOLS |m1|))
                           (LETT |m3| (SPADCALL |m1| (QREFELT $ 28)))
                           (LETT |nr| (ANROWS |m3|)) (LETT |j| 1)
                           (LETT |i0| (+ |nr| 1)) (LETT |sl| NIL)
                           (SEQ
                            (EXIT
                             (SEQ (LETT |i| 1) (LETT #8# |nr|) G190
                                  (COND ((|greater_SI| |i| #8#) (GO G191)))
                                  (SEQ
                                   (SEQ G190
                                        (COND
                                         ((NULL
                                           (COND
                                            ((<= |j| |nn|)
                                             (SPADCALL
                                              (SPADCALL |m3| |i| |j|
                                                        (QREFELT $ 32))
                                              (|spadConstant| $ 33)
                                              (QREFELT $ 34)))
                                            ('T NIL)))
                                          (GO G191)))
                                        (SEQ (EXIT (LETT |j| (+ |j| 1)))) NIL
                                        (GO G190) G191 (EXIT NIL))
                                   (COND
                                    ((> |j| |nn|)
                                     (SEQ (LETT |i0| |i|)
                                          (EXIT
                                           (PROGN
                                            (LETT #7# |$NoValue|)
                                            (GO #13=#:G725))))))
                                   (LETT |cv|
                                         (MAKEARR1 |nn| (|spadConstant| $ 37)))
                                   (SEQ (LETT |k| 1) (LETT #6# |nn|) G190
                                        (COND
                                         ((|greater_SI| |k| #6#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (SPADCALL |cv| |k|
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL |m3| |i| |k|
                                                                (QREFELT $ 32))
                                                      (QREFELT $ 38))
                                                     (QREFELT $ 39))
                                                    (QREFELT $ 41))))
                                        (LETT |k| (|inc_SI| |k|)) (GO G190)
                                        G191 (EXIT NIL))
                                   (LETT |s| (|spadConstant| $ 37))
                                   (SEQ (LETT |bf| NIL) (LETT #5# |bas|)
                                        (LETT |k| 1) (LETT #4# |nc|) G190
                                        (COND
                                         ((OR (|greater_SI| |k| #4#) (ATOM #5#)
                                              (PROGN
                                               (LETT |bf| (CAR #5#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT |s|
                                                (SPADCALL |s|
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (SPADCALL |m3| |i|
                                                                      |k|
                                                                      (QREFELT
                                                                       $ 32))
                                                            (QREFELT $ 38))
                                                           |bf| (QREFELT $ 42))
                                                          (QREFELT $ 43)))))
                                        (LETT |k|
                                              (PROG1 (|inc_SI| |k|)
                                                (LETT #5# (CDR #5#))))
                                        (GO G190) G191 (EXIT NIL))
                                   (EXIT
                                    (LETT |sl| (CONS (CONS |s| |cv|) |sl|))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT NIL)))
                            #13# (EXIT #7#))
                           (LETT |bl| NIL)
                           (SEQ (LETT |i| |i0|) (LETT #3# |nr|) G190
                                (COND ((> |i| #3#) (GO G191)))
                                (SEQ (LETT |s| (|spadConstant| $ 37))
                                     (SEQ (LETT |bf| NIL) (LETT #2# |bas|)
                                          (LETT |k| 1) (LETT #1# |nc|) G190
                                          (COND
                                           ((OR (|greater_SI| |k| #1#)
                                                (ATOM #2#)
                                                (PROGN
                                                 (LETT |bf| (CAR #2#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT |s|
                                                  (SPADCALL |s|
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL |m3|
                                                                        |i| |k|
                                                                        (QREFELT
                                                                         $ 32))
                                                              (QREFELT $ 38))
                                                             |bf|
                                                             (QREFELT $ 42))
                                                            (QREFELT $ 43)))))
                                          (LETT |k|
                                                (PROG1 (|inc_SI| |k|)
                                                  (LETT #2# (CDR #2#))))
                                          (GO G190) G191 (EXIT NIL))
                                     (EXIT (LETT |bl| (CONS |s| |bl|))))
                                (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                           (EXIT (CONS |sl| |bl|))))))))) 

(SDEFUN |ODEPAL;RF_to_F| ((|rf| (|Fraction| UP)) ($ (F)))
        (SPADCALL (SPADCALL |rf| (QREFELT $ 44)) (QREFELT $ 45))) 

(SDEFUN |ODEPAL;V_to_VF| ((|v| (|Vector| (|Fraction| UP))) ($ (|Vector| F)))
        (SPADCALL (CONS (|function| |ODEPAL;RF_to_F|) $) |v| (QREFELT $ 48))) 

(SDEFUN |ODEPAL;algDsolve;LodoLR;4|
        ((|l| (|LinearOrdinaryDifferentialOperator1| R)) (|lg| (|List| R))
         ($
          (|Record|
           (|:| |particular|
                (|List|
                 (|Record| (|:| |ratpart| R) (|:| |coeffs| (|Vector| F)))))
           (|:| |basis| (|List| R)))))
        (SPROG
         ((|part|
           (|List| (|Record| (|:| |ratpart| R) (|:| |coeffs| (|Vector| F)))))
          (#1=#:G765 NIL) (|be| NIL) (#2=#:G764 NIL) (|bas| (|List| R))
          (#3=#:G763 NIL) (|v| NIL) (#4=#:G762 NIL)
          (|sol|
           (|Record|
            (|:| |particular|
                 (|List|
                  (|Record| (|:| |ratpart| (|Vector| (|Fraction| UP)))
                            (|:| |coeffs| (|Vector| (|Fraction| UP))))))
            (|:| |basis| (|List| (|Vector| (|Fraction| UP))))))
          (|rec|
           (|Record|
            (|:| |mat|
                 (|Matrix|
                  (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP))))
            (|:| |vecs| (|List| (|Vector| (|Fraction| UP)))))))
         (SEQ (LETT |rec| (SPADCALL |l| |lg| (QREFELT $ 53)))
              (LETT |sol|
                    (SPADCALL (QCAR |rec|) (QCDR |rec|)
                              (CONS (|function| |ODEPAL;rat_solve|) $)
                              (QREFELT $ 62)))
              (LETT |bas|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |v| NIL) (LETT #3# (QCDR |sol|)) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |v| (CAR #3#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS (SPADCALL |v| (QREFELT $ 63)) #4#))))
                          (LETT #3# (CDR #3#)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT |part|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |be| NIL) (LETT #1# (QCAR |sol|)) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |be| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (CONS (SPADCALL (QCAR |be|) (QREFELT $ 63))
                                         (|ODEPAL;V_to_VF| (QCDR |be|) $))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (CONS |part| |bas|))))) 

(SDEFUN |ODEPAL;algDsolve;LodoRR;5|
        ((|l| (|LinearOrdinaryDifferentialOperator1| R)) (|g| (R))
         ($
          (|Record| (|:| |particular| (|Union| R "failed"))
                    (|:| |basis| (|List| R)))))
        (SPROG
         ((|s1| (R)) (|s0| (R)) (|c1inv| (F))
          (|part1| (|Record| (|:| |ratpart| R) (|:| |coeffs| (|Vector| F))))
          (|bas| #1=(|List| R))
          (|rec1|
           (|Record|
            (|:| |particular|
                 (|List|
                  (|Record| (|:| |ratpart| R) (|:| |coeffs| (|Vector| F)))))
            (|:| |basis| #1#))))
         (SEQ (LETT |rec1| (SPADCALL |l| (LIST |g|) (QREFELT $ 66)))
              (LETT |bas| (QCDR |rec1|))
              (EXIT
               (COND ((NULL (QCAR |rec1|)) (CONS (CONS 1 "failed") |bas|))
                     ('T
                      (SEQ (LETT |part1| (|SPADfirst| (QCAR |rec1|)))
                           (LETT |c1inv|
                                 (SPADCALL
                                  (SPADCALL (QCDR |part1|) 1 (QREFELT $ 67))
                                  (QREFELT $ 68)))
                           (LETT |s0| (QCAR |part1|))
                           (LETT |s1|
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |c1inv| (QREFELT $ 38))
                                            (QREFELT $ 39))
                                  |s0| (QREFELT $ 69)))
                           (EXIT (CONS (CONS 0 |s1|) |bas|))))))))) 

(DECLAIM (NOTINLINE |PureAlgebraicLODE;|)) 

(DEFUN |PureAlgebraicLODE| (&REST #1=#:G779)
  (SPROG NIL
         (PROG (#2=#:G780)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PureAlgebraicLODE|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PureAlgebraicLODE;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PureAlgebraicLODE|)))))))))) 

(DEFUN |PureAlgebraicLODE;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|PureAlgebraicLODE| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 73))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|PureAlgebraicLODE|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|PureAlgebraicLODE| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|)
              (|Record| (|:| |basis| 12) (|:| |mat| 18))
              (|LinearOrdinaryDifferentialOperator1| 36) (|List| 36)
              (|RationalLODE| 6 7) (0 . |ratDsolve|) (|Vector| $) (6 . |basis|)
              (|List| 24) (|Matrix| 6) (10 . |nullSpace|) (|Boolean|)
              (|NonNegativeInteger|) (15 . ~=) (|List| 6) (|Vector| 6)
              (21 . |entries|) (|List| 23) (26 . |matrix|) (31 . |rowEchelon|)
              (36 . |One|) (40 . |One|) (|Integer|) (44 . |elt|) (51 . |Zero|)
              (55 . =) (61 . |Zero|) (|Fraction| 7) (65 . |Zero|)
              (69 . |coerce|) (74 . |coerce|) (|Vector| 36) (79 . |setelt!|)
              (86 . *) (92 . +) (98 . |retract|) (103 . |ground|)
              (|Mapping| 6 36) (|VectorFunctions2| 36 6) (108 . |map|)
              (|Record| (|:| |mat| 56) (|:| |vecs| 57))
              (|LinearOrdinaryDifferentialOperator1| 9) (|List| 9)
              (|ReduceLODE| 36 11 8 9 50) (114 . |reduceLODE|)
              (|Record| (|:| |ratpart| 40) (|:| |coeffs| 40))
              (|Record| (|:| |particular| (|List| 54)) (|:| |basis| 57))
              (|Matrix| 11) (|List| 40)
              (|Record| (|:| |ratpart| 36) (|:| |coeffs| 40))
              (|Record| (|:| |particular| (|List| 58)) (|:| |basis| 12))
              (|Mapping| 59 11 12) (|SystemODESolver| 36 11)
              (120 . |solveInField|) (127 . |represents|)
              (|Record| (|:| |ratpart| 9) (|:| |coeffs| 24))
              (|Record| (|:| |particular| (|List| 64)) (|:| |basis| 51))
              |ODEPAL;algDsolve;LodoLR;4| (132 . |elt|) (138 . |inv|) (143 . *)
              (|Union| 9 '#1="failed")
              (|Record| (|:| |particular| 70) (|:| |basis| 51))
              |ODEPAL;algDsolve;LodoRR;5|)
           '#(|algDsolve| 149) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|algDsolve|
                                 ((|Record|
                                   (|:| |particular| (|Union| |#4| #1#))
                                   (|:| |basis| (|List| |#4|)))
                                  (|LinearOrdinaryDifferentialOperator1| |#4|)
                                  |#4|))
                                T)
                              '((|algDsolve|
                                 ((|Record|
                                   (|:| |particular|
                                        (|List|
                                         (|Record| (|:| |ratpart| |#4|)
                                                   (|:| |coeffs|
                                                        (|Vector| |#1|)))))
                                   (|:| |basis| (|List| |#4|)))
                                  (|LinearOrdinaryDifferentialOperator1| |#4|)
                                  (|List| |#4|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 72
                                            '(2 13 10 11 12 14 0 9 15 16 1 18
                                              17 0 19 2 21 20 0 0 22 1 24 23 0
                                              25 1 18 0 26 27 1 18 0 0 28 0 6 0
                                              29 0 7 0 30 3 18 6 0 31 31 32 0 6
                                              0 33 2 6 20 0 0 34 0 7 0 35 0 36
                                              0 37 1 7 0 6 38 1 36 0 7 39 3 40
                                              36 0 31 36 41 2 36 0 7 0 42 2 36
                                              0 0 0 43 1 36 7 0 44 1 7 6 0 45 2
                                              47 24 46 40 48 2 52 49 50 51 53 3
                                              61 55 56 57 60 62 1 9 0 40 63 2
                                              24 6 0 31 67 1 6 0 0 68 2 9 0 36
                                              0 69 2 0 65 50 51 66 2 0 71 50 9
                                              72)))))
           '|lookupComplete|)) 
