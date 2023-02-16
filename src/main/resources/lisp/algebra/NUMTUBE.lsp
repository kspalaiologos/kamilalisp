
(SDEFUN |NUMTUBE;colinearity|
        ((|x| (|Point| (|DoubleFloat|))) (|y| (|Point| (|DoubleFloat|)))
         ($ (|DoubleFloat|)))
        (|div_DF| (|expt_DF_I| (SPADCALL |x| |y| (QREFELT $ 16)) 2)
                  (|mul_DF| (SPADCALL |x| |x| (QREFELT $ 16))
                            (SPADCALL |y| |y| (QREFELT $ 16))))) 

(SDEFUN |NUMTUBE;orthog|
        ((|x| (|Point| (|DoubleFloat|))) (|y| (|Point| (|DoubleFloat|)))
         ($ (|Point| (|DoubleFloat|))))
        (SPROG ((|a| (|DoubleFloat|)))
               (SEQ
                (COND
                 ((SPADCALL (|NUMTUBE;colinearity| |x| |y| $) (QREFELT $ 7)
                            (QREFELT $ 18))
                  (LETT |y| (QREFELT $ 15))))
                (COND
                 ((SPADCALL (|NUMTUBE;colinearity| |x| |y| $) (QREFELT $ 7)
                            (QREFELT $ 18))
                  (LETT |y|
                        (COND
                         ((|less_DF|
                           (|NUMTUBE;colinearity| |x| (QREFELT $ 12) $)
                           (QREFELT $ 7))
                          (QREFELT $ 12))
                         ('T (QREFELT $ 13))))))
                (LETT |a|
                      (|minus_DF|
                       (|div_DF| (SPADCALL |x| |y| (QREFELT $ 16))
                                 (SPADCALL |x| |x| (QREFELT $ 16)))))
                (EXIT
                 (SETELT $ 15
                         (SPADCALL (SPADCALL |a| |x| (QREFELT $ 19)) |y|
                                   (QREFELT $ 20))))))) 

(SDEFUN |NUMTUBE;poTriad|
        ((|pl| (|Point| (|DoubleFloat|))) (|po| (|Point| (|DoubleFloat|)))
         (|pr| (|Point| (|DoubleFloat|)))
         ($
          (|Record| (|:| |tang| (|Point| (|DoubleFloat|)))
                    (|:| |norm| (|Point| (|DoubleFloat|)))
                    (|:| |bin| (|Point| (|DoubleFloat|))))))
        (SPROG
         ((|n| #1=(|Point| (|DoubleFloat|))) (|pol| (|Point| (|DoubleFloat|)))
          (|t| #1#))
         (SEQ
          (LETT |t|
                (SPADCALL (SPADCALL |pr| |pl| (QREFELT $ 21)) (QREFELT $ 22)))
          (LETT |pol| (SPADCALL |pl| |po| (QREFELT $ 21)))
          (LETT |n| (SPADCALL (|NUMTUBE;orthog| |t| |pol| $) (QREFELT $ 22)))
          (EXIT (VECTOR |t| |n| (SPADCALL |t| |n| (QREFELT $ 23))))))) 

(SDEFUN |NUMTUBE;curveTriads|
        ((|l| (|List| (|Point| (|DoubleFloat|))))
         ($
          (|List|
           #1=(|Record| (|:| |tang| (|Point| (|DoubleFloat|)))
                        (|:| |norm| (|Point| (|DoubleFloat|)))
                        (|:| |bin| (|Point| (|DoubleFloat|)))))))
        (SPROG
         ((|endtriad| #1#) (|n| #2=(|Point| (|DoubleFloat|))) (|t| #2#)
          (|x|
           (|Record| (|:| |tang| (|Point| (|DoubleFloat|)))
                     (|:| |norm| (|Point| (|DoubleFloat|)))
                     (|:| |bin| (|Point| (|DoubleFloat|)))))
          (|begtriad| #1#)
          (|midtriads|
           (|List|
            (|Record| (|:| |tang| (|Point| (|DoubleFloat|)))
                      (|:| |norm| (|Point| (|DoubleFloat|)))
                      (|:| |bin| (|Point| (|DoubleFloat|))))))
          (#3=#:G737 NIL) (|pl| NIL) (#4=#:G738 NIL) (|po| NIL) (#5=#:G739 NIL)
          (|pr| NIL) (#6=#:G736 NIL) (|triad| #1#)
          (|b| (|Point| (|DoubleFloat|))) (|k| (|NonNegativeInteger|)))
         (SEQ (LETT |k| (LENGTH |l|))
              (EXIT
               (COND
                ((< |k| 2)
                 (|error| "Need at least 2 points to specify a curve"))
                (#7='T
                 (SEQ (SETELT $ 15 (QREFELT $ 14))
                      (EXIT
                       (COND
                        ((EQL |k| 2)
                         (SEQ
                          (LETT |t|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 25))
                                           (|SPADfirst| |l|) (QREFELT $ 21))
                                 (QREFELT $ 22)))
                          (LETT |n|
                                (SPADCALL
                                 (SPADCALL |t| (QREFELT $ 12) (QREFELT $ 21))
                                 (QREFELT $ 22)))
                          (LETT |b| (SPADCALL |t| |n| (QREFELT $ 23)))
                          (LETT |triad| (VECTOR |t| |n| |b|))
                          (EXIT (LIST |triad| |triad|))))
                        (#7#
                         (SEQ
                          (LETT |midtriads|
                                (PROGN
                                 (LETT #6# NIL)
                                 (SEQ (LETT |pr| NIL)
                                      (LETT #5# (CDR (CDR |l|)))
                                      (LETT |po| NIL) (LETT #4# (CDR |l|))
                                      (LETT |pl| NIL) (LETT #3# |l|) G190
                                      (COND
                                       ((OR (ATOM #3#)
                                            (PROGN (LETT |pl| (CAR #3#)) NIL)
                                            (ATOM #4#)
                                            (PROGN (LETT |po| (CAR #4#)) NIL)
                                            (ATOM #5#)
                                            (PROGN (LETT |pr| (CAR #5#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #6#
                                              (CONS
                                               (|NUMTUBE;poTriad| |pl| |po|
                                                |pr| $)
                                               #6#))))
                                      (LETT #3#
                                            (PROG1 (CDR #3#)
                                              (LETT #4#
                                                    (PROG1 (CDR #4#)
                                                      (LETT #5# (CDR #5#))))))
                                      (GO G190) G191 (EXIT (NREVERSE #6#)))))
                          (LETT |x| (|SPADfirst| |midtriads|))
                          (LETT |t|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 25))
                                           (|SPADfirst| |l|) (QREFELT $ 21))
                                 (QREFELT $ 22)))
                          (LETT |n|
                                (SPADCALL
                                 (|NUMTUBE;orthog| |t| (QVELT |x| 1) $)
                                 (QREFELT $ 22)))
                          (LETT |begtriad|
                                (VECTOR |t| |n|
                                        (SPADCALL |t| |n| (QREFELT $ 23))))
                          (LETT |x| (SPADCALL |midtriads| (QREFELT $ 28)))
                          (LETT |t|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |l| |k| (QREFELT $ 30))
                                           (SPADCALL |l| (- |k| 1)
                                                     (QREFELT $ 30))
                                           (QREFELT $ 21))
                                 (QREFELT $ 22)))
                          (LETT |n|
                                (SPADCALL
                                 (|NUMTUBE;orthog| |t| (QVELT |x| 1) $)
                                 (QREFELT $ 22)))
                          (LETT |endtriad|
                                (VECTOR |t| |n|
                                        (SPADCALL |t| |n| (QREFELT $ 23))))
                          (EXIT
                           (CONS |begtriad|
                                 (SPADCALL |midtriads| |endtriad|
                                           (QREFELT $ 31))))))))))))))) 

(SDEFUN |NUMTUBE;curveLoops|
        ((|pts| (|List| (|Point| (|DoubleFloat|)))) (|r| (|DoubleFloat|))
         (|nn| (|Integer|)) ($ (|List| (|List| (|Point| (|DoubleFloat|))))))
        (SPROG
         ((|loops| (|List| (|List| (|Point| (|DoubleFloat|)))))
          (|b| #1=(|Point| (|DoubleFloat|))) (|n| #2=(|Point| (|DoubleFloat|)))
          (#3=#:G746 NIL) (|pt| NIL) (#4=#:G747 NIL) (|triad| NIL)
          (|cosSin| (|List| (|List| (|DoubleFloat|))))
          (|triads|
           (|List|
            (|Record| (|:| |tang| (|Point| (|DoubleFloat|))) (|:| |norm| #2#)
                      (|:| |bin| #1#)))))
         (SEQ (LETT |triads| (|NUMTUBE;curveTriads| |pts| $))
              (LETT |cosSin| (SPADCALL |nn| (QREFELT $ 33))) (LETT |loops| NIL)
              (SEQ (LETT |triad| NIL) (LETT #4# |triads|) (LETT |pt| NIL)
                   (LETT #3# |pts|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |pt| (CAR #3#)) NIL)
                         (ATOM #4#) (PROGN (LETT |triad| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |n| (QVELT |triad| 1))
                        (LETT |b| (QVELT |triad| 2))
                        (EXIT
                         (LETT |loops|
                               (CONS
                                (SPADCALL |pt| |n| |b| |r| |cosSin|
                                          (QREFELT $ 34))
                                |loops|))))
                   (LETT #3# (PROG1 (CDR #3#) (LETT #4# (CDR #4#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT (NREVERSE |loops|))))) 

(SDEFUN |NUMTUBE;tube;CurveDfITp;6|
        ((|curve| (|Curve|)) (|r| (|DoubleFloat|)) (|n| (|Integer|))
         ($ (|TubePlot| |Curve|)))
        (SPROG
         ((|loops| (|List| (|List| (|Point| (|DoubleFloat|))))) (#1=#:G752 NIL)
          (|bran| NIL) (|brans| (|List| (|List| (|Point| (|DoubleFloat|))))))
         (SEQ
          (COND ((< |n| 3) (|error| "tube: n should be at least 3"))
                ('T
                 (SEQ (LETT |brans| (SPADCALL |curve| (QREFELT $ 36)))
                      (LETT |loops| NIL)
                      (SEQ (LETT |bran| NIL) (LETT #1# |brans|) G190
                           (COND
                            ((OR (ATOM #1#)
                                 (PROGN (LETT |bran| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT |loops|
                                   (SPADCALL |loops|
                                             (|NUMTUBE;curveLoops| |bran| |r|
                                              |n| $)
                                             (QREFELT $ 37)))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT (SPADCALL |curve| |loops| NIL (QREFELT $ 39))))))))) 

(DECLAIM (NOTINLINE |NumericTubePlot;|)) 

(DEFUN |NumericTubePlot| (#1=#:G753)
  (SPROG NIL
         (PROG (#2=#:G754)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|NumericTubePlot|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|NumericTubePlot;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|NumericTubePlot|)))))))))) 

(DEFUN |NumericTubePlot;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|NumericTubePlot| DV$1))
          (LETT $ (GETREFV 41))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|NumericTubePlot| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|mk_DF| 995 -3))
          (QSETREFV $ 12 (SPADCALL 1.0 0.0 0.0 0.0 (QREFELT $ 11)))
          (QSETREFV $ 13 (SPADCALL 0.0 1.0 0.0 0.0 (QREFELT $ 11)))
          (QSETREFV $ 14 (SPADCALL 1.0 1.0 0.0 0.0 (QREFELT $ 11)))
          (QSETREFV $ 15 (QREFELT $ 14))
          $))) 

(MAKEPROP '|NumericTubePlot| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) 'LINMAX (|Point| 9)
              (|DoubleFloat|) (|TubePlotTools|) (0 . |point|) 'XHAT 'YHAT
              'PREV0 'PREV (8 . |dot|) (|Boolean|) (14 . >) (20 . *) (26 . +)
              (32 . -) (38 . |unitVector|) (43 . |cross|) (|List| 8)
              (49 . |second|)
              (|Record| (|:| |tang| 8) (|:| |norm| 8) (|:| |bin| 8))
              (|List| 26) (54 . |last|) (|Integer|) (59 . |elt|)
              (65 . |concat|) (|List| (|List| 9)) (71 . |cosSinInfo|)
              (76 . |loopPoints|) (|List| 24) (85 . |listBranches|)
              (90 . |concat|) (|TubePlot| 6) (96 . |tube|)
              |NUMTUBE;tube;CurveDfITp;6|)
           '#(|tube| 103) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|tube|
                                 ((|TubePlot| |#1|) |#1| (|DoubleFloat|)
                                  (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 40
                                            '(4 10 8 9 9 9 9 11 2 10 9 8 8 16 2
                                              9 17 0 0 18 2 10 8 9 8 19 2 10 8
                                              8 8 20 2 10 8 8 8 21 1 10 8 8 22
                                              2 10 8 8 8 23 1 24 8 0 25 1 27 26
                                              0 28 2 24 8 0 29 30 2 27 0 0 26
                                              31 1 10 32 29 33 5 10 24 8 8 8 9
                                              32 34 1 6 35 0 36 2 35 0 0 0 37 3
                                              38 0 6 35 17 39 3 0 38 6 9 29
                                              40)))))
           '|lookupComplete|)) 
